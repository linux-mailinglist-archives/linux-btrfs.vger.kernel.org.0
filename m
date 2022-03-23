Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31944E5079
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 11:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiCWKkt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 06:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiCWKkq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 06:40:46 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684B53EF3B
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648031956; x=1679567956;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xQIVvqbFBpjDnDKICYtayJqHWPPVNr/d4+sOvAVDGeE=;
  b=Gd6fql70drRfp1VDsQuBPCA3G/TwPz3esd1WraJ8AXBhDvVUGueXcKAD
   8XusnUzcswgLDbj19sO9zPBgSSfGYnGaI11tVwuqY5yBVtZwX15lWb9P1
   KibEmaz8CZHppX9EpZVTa+dmOMEsSso3fX2LzuHMGxDeGx0eXg9JK9KIT
   haJCtZ11yCwId0KGd17VBzEo0CeLS5tWWZRAEOxxvVXlb62mkL92zOG90
   I+BEee/yTNJnD2dOH1v11EPvqG+Hw8sErcMRpeEy1v99T9zHXyQY1wAtD
   iaHwTAf+M+j7bvO9+9r8P8Q6RzAP3qT24xgPBTje0zbxJIKnCkzJ3Ao4r
   w==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="308006120"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 18:39:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a07BSCzvMBPPrkjAcDXWqXEyCiIyhVp5IzVJlMRKGnv9I783ojkVsvfRMtEm92bPJD5NXtpJ8hO5YeSuZsHek1vUKX3L4GE5g954xeyiut7VNY2Hb2zMfnRSn3iWjyZ69qz/jZ9JqKaCV0/9giHa2wzvxfoXROQ34tMfGJFFAzg/TI6QzJwA5m8vzRoXsWqNqddg5Uy1ezSL408PcDS0Azuy+qMI+dHKzS1ca8JWJllCld30iefJYlPVSnuVoau5MXaPPGOGJt1aAg6d8hnY0JW0XVCsNU4bN77LhNNyg5BaCDfoOx7ChIlrbPqk4qDgXf+udjAod8hZbybezeT7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=je0Kgs+VnhqucRJgsKV0dQ9PP3oMwuFlxsBPVZndNlI=;
 b=lSSToNUqXyuGSWIpthhJ5xSkph+WGUguW2k1n3fgd/aEWS+PfjGRsHJr9U98eCuV0Tw/0hKllFMZrd3E9FgDQsC91AzKWcwF1KyGeukcTuX2Shd7F2NGa/+RV9HHTSH3XFE7bRAYh0iXuzc4NkiDN0YD1lqrX+v23zSi+ieOEzzCvCNfJVLAgOwO1Bsn7K00vO3ZPBiSEr9JGWq1jpiWnxoUUB1ZQh4R66FdMmMz1xcKYMHm3UB0b+ynxBbAqx42Q7ZMmRQbR0wZgPHNl9GabOCZQeuZYV5tSb+ZCLExWRCE5RYcvgr4w9igwmqHaWMPs8kVU9efLElNYkfNkrwRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=je0Kgs+VnhqucRJgsKV0dQ9PP3oMwuFlxsBPVZndNlI=;
 b=xpvLaRHqoAdk/T2/+kOxQZvknD1b3Q+eED+BtzkpmcRrqWyBY4HeOS825BRmp1MaBf624083yWcXP6+Ph7BB7brYcffJPIwkPIPab2pcEI+2gooGWd9Ez+cCtQZCRQ0slN6XsrzVI7m+pBxf0elc6Ca7heqExF7/SzTUXUi5o+0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0481.namprd04.prod.outlook.com (2603:10b6:300:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Wed, 23 Mar
 2022 10:39:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 10:39:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        David Sterba <dsterba@suse.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Thread-Topic: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Thread-Index: AQHYPT7Bez0AiBAkLkKxIm3VhJQQ/Q==
Date:   Wed, 23 Mar 2022 10:39:12 +0000
Message-ID: <PH0PR04MB7416E2A6492CA8BB2DF07BE09B189@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
 <CGME20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4@eucas1p2.samsung.com>
 <89824f8b4ba1ac8f05f74c047333c970049e2815.1647878642.git.johannes.thumshirn@wdc.com>
 <f4e4a70c-0349-fafa-8375-8c4177a3e260@samsung.com>
 <PH0PR04MB7416CD1BC88132E22790A1869B189@PH0PR04MB7416.namprd04.prod.outlook.com>
 <b0e84388-b56f-d8b9-2795-ec8d74431475@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00e02c7e-a193-4bf1-bfde-08da0cb95ee1
x-ms-traffictypediagnostic: MWHPR04MB0481:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0481C253DCD06A8FE9B8D22B9B189@MWHPR04MB0481.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6fPX/zN/M8Y5D2QQwUIUHNdyr7/I26YzuExfaqsPucEIDaYRhHWtIL9DiMY+IGOIiVuR/RADAazXXzH+0nNd6K3fu0nrQcnWiaXpOkd1lvhmZJsWpjPobghiKbI7MsI8usG+DcBc1q0QYOM3dMdLVMWX/u75IFVj06zvxWTxWBS/NS3vwrZU4Jn+x2LsCTL/oWBQ9OA6pFvs3MYY72cjji5D1TLVvOzdGiu81vpBOJNWql4gFgDZSibw7/HvMGYcZos/Zm+b+6FvGX/snEwA2+kxJsELLGNv4h1xT0COeBIQQubMQaKg3QFYiTK3ZA7hi24tZmjmFLV32H8vrgjhkNCE9YpLcBeS+aMv7si/mvGysO7L9d8t/TnGMQpZb0owRwCwcSg+ANH/VPEOY6aa4QOh2pPB9VHhElJdtsoD2twI+fGLrt5qmziUYbuiNDpt8/hwxsX1n2VWnsDf6o1KrIXgJicKtFTtUjdBvQRXSQ895oZYrPeGlTTolwArJnglMqcgQKiR2NTKOOp8xRxS1+QT1e8eglxMNqxXhLHRha6WuhW1jcFkEOlZmCbsmwpzHsr3GrMu6lYDD4QD+2tVPggL8uH8c9WkTpGT6Undxo6RzBjbwpnlm/Z/YDMNUT5ztzWVl1ZXha/GkWnlcOizzig43Kmmd0drD4MCLJJ0UZ46sm6WRypHtqmUio0mGURU1AWYwo+WXKCYWRdWJhcwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(38070700005)(9686003)(66946007)(122000001)(38100700002)(5660300002)(82960400001)(33656002)(110136005)(508600001)(7696005)(6506007)(316002)(2906002)(71200400001)(53546011)(54906003)(86362001)(66556008)(66476007)(76116006)(64756008)(66446008)(91956017)(52536014)(186003)(8936002)(83380400001)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PhbFi1V+jFPbKLMS8iNaIi7H17D/ksS7nZtxC7B1pmQ6OKrgkroJXDuTIHXu?=
 =?us-ascii?Q?QcnAF+cKNpTPBC9dX4C+MUknubwLlE6dLS/hglGCKcJjJ2n1NOZdraWRaRg2?=
 =?us-ascii?Q?YHbBidN9URrfyWlc0Zvmr/BfeyFcTUxeGYct8b2TttDii+MelYdhPWLvo8OV?=
 =?us-ascii?Q?zeveUM0qLerCmkDmG4PPNLJ2DzR+xvj1Q5pchIfn1stypMNeULh7PL10AQwK?=
 =?us-ascii?Q?XRkWpOnK+Mn2A1bqr1pGBHEB6gke1x33IRHfHNqEBTeN/joqO58VDx/uUt8X?=
 =?us-ascii?Q?l/HAhMgTQtTMi2fMmLKgkZ2gC5zq0QEcYKB/cX/KeOVi/43SRvc3hjWTWPOD?=
 =?us-ascii?Q?v26yQE6H722n1nkh+/vSTOpcO+JCq+6B5jXQ8PiK3MelvZYN2TXtnet7tnhW?=
 =?us-ascii?Q?cOmFeBCUaNU3Y32ii8gLBDn/3yDzH8kOgESHMOTlETIEOvPZoDrAQeLqkpMl?=
 =?us-ascii?Q?kgBHxRQVW4QhfJAPCyBeBiWxBP0T00aIH6QYN5573JMSLsdKpCB5LjSmmp3a?=
 =?us-ascii?Q?0QVjmIUHWfndaXo4aU0qYLEZ+AC7DRVwo0YI2O+CPi1g/wJ4o7Yja04kuKME?=
 =?us-ascii?Q?Fc3s+wfd4RP+3iGyJsyvGmJ375VzocuSyPyVETvOJnAGQoOlHeUXJcBkZIjL?=
 =?us-ascii?Q?x3CO806WBd96ppyqoAMO2FqE2/nf1R6jwv+hFMWmbuvBEbqH9m4lil9EH4an?=
 =?us-ascii?Q?EkS6zX8Repg6giEAUdnrisRrw6Pz+l/8tDARPOmiBec94dYjJWtaUeB0j2QV?=
 =?us-ascii?Q?NTJU1xnt+MEf4IWqXTr4a5mg6u/pwx08USOOEcTLONvwAbw6hyt3O3YM0hNm?=
 =?us-ascii?Q?VANxxuZX5b58zBhk4G0dqGEYZHc4P3fw9Q1DQjUBgHl7cK6l66bslAkXmzEY?=
 =?us-ascii?Q?h3c4pIopE4e1k76BUqT6ToCLjtQyOAMilQXyiDdJCes/Z7DXOHF0xJe/Lxb4?=
 =?us-ascii?Q?5/w4DIDE5aTx07wFWCUJKC0Vm8b0RwdqaFS7PUHKjEILqYEXcOHjzu/fJ90w?=
 =?us-ascii?Q?QSnbaJYaXLK9aGZ8UciMg3NSu5WCTy5AoLQYguhz92VHfGDIZX6VT+iCS8Jp?=
 =?us-ascii?Q?2KRJc/nkHCmV6+X7RTARf+fpxFnl+eNNRgQSIqKOCSbSpknPBge12AtyrLeD?=
 =?us-ascii?Q?IHqdHxbqAxcMcasA7KIwIwY1D9ycAVJA9D1rtRzLix9PGh8Je8MY69W/CqqI?=
 =?us-ascii?Q?FQt1rvYjaDor+2vgXPMad1oIp0PFcidzVXCiy98TfqN/6EGMDhAM6OeIvFVL?=
 =?us-ascii?Q?NjsWHR/WKfBnlTnPSPo3tyS5IUqJ8gwTNENGAgD2thSkGuDN7QfmjQSaEqxL?=
 =?us-ascii?Q?hm4LQn0qie5tSl/F8fePehLkaTCaxo2nKHhBJSpXjH1dkW3ZHcoeRagy7eGR?=
 =?us-ascii?Q?CgbOyb9xBXOxwQNt5MKTmYG9TFzNhLuvlf1iHxshb1zH9NOexDx+2taWscD/?=
 =?us-ascii?Q?yoJwsGOZVM/TAPRBc15weGGK1MOVRiEhYHNcLWs34+9NHmgz/O3zRua6BAd9?=
 =?us-ascii?Q?tRbtTGHTal+urfWkoHW4pM1AY2zTBJSL+JzdQqL68dwA25w2u/jWEK83ndg9?=
 =?us-ascii?Q?uv2EeuIzM0ybJW8JGL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e02c7e-a193-4bf1-bfde-08da0cb95ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 10:39:12.5433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKGjZKtfp1cfIEbPmjGtA+KmfCx6rVzwnZ/y05aD71FBajAD5vH5q3xRFOnPBHa/0Bb0UCiqbQpgSTLfEoI4HZMWrhIwjU0HfJaTHxn10ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0481
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2022 10:14, Pankaj Raghav wrote:=0A=
> =0A=
> =0A=
> On 2022-03-23 10:11, Johannes Thumshirn wrote:=0A=
>> On 23/03/2022 10:09, Pankaj Raghav wrote:=0A=
>>> I am also noticing the same behaviour for ZNS drive with size 1280M:=0A=
>>>=0A=
>>> [   86.276409] btrfs: factor: 350 used: 1409286144, total: 402653184=0A=
>>>=0A=
>>> Is something going wrong with the calculation? Or am I missing somethin=
g=0A=
>>> here?=0A=
>>>=0A=
>>=0A=
>> Apparently I'm either too dumb for basic maths, or =0A=
>> btrfs_calc_available_free_space() doesn't give us the values we're expec=
ting.=0A=
>>=0A=
> I would say the latter :)=0A=
>> I'll recheck.=0A=
> Let me know if you can also reproduce the results.=0A=
> =0A=
=0A=
It looks like we can't use btrfs_calc_available_free_space(), can=0A=
you try this one on top:=0A=
=0A=
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
index f2a412427921..4a6c1f1a7223 100644=0A=
--- a/fs/btrfs/zoned.c=0A=
+++ b/fs/btrfs/zoned.c=0A=
@@ -2082,23 +2082,27 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs=
_info)=0A=
 =0A=
 bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)=0A=
 {=0A=
-       struct btrfs_space_info *sinfo;=0A=
+       struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;=0A=
+       struct btrfs_device *device;=0A=
        u64 used =3D 0;=0A=
        u64 total =3D 0;=0A=
        u64 factor;=0A=
 =0A=
-       if (!btrfs_is_zoned(fs_info))=0A=
-               return false;=0A=
-=0A=
        if (!fs_info->bg_reclaim_threshold)=0A=
                return false;=0A=
 =0A=
-       list_for_each_entry(sinfo, &fs_info->space_info, list) {=0A=
-               total +=3D sinfo->total_bytes;=0A=
-               used +=3D btrfs_calc_available_free_space(fs_info, sinfo,=
=0A=
-                                                       BTRFS_RESERVE_NO_FL=
USH);=0A=
+=0A=
+       mutex_lock(&fs_devices->device_list_mutex);=0A=
+       list_for_each_entry(device, &fs_devices->devices, dev_list) {=0A=
+               if (!device->bdev)=0A=
+                       continue;=0A=
+=0A=
+               total +=3D device->disk_total_bytes;=0A=
+               used +=3D device->bytes_used;=0A=
+=0A=
        }=0A=
+       mutex_unlock(&fs_devices->device_list_mutex);=0A=
 =0A=
-       factor =3D div_u64(used * 100, total);=0A=
+       factor =3D div64_u64(used * 100, total);=0A=
        return factor >=3D fs_info->bg_reclaim_threshold;=0A=
 }=0A=
=0A=
