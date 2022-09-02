Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891D25AB53F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiIBPcd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 11:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiIBPcM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 11:32:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D5FBC11
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662131649; x=1693667649;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cgX9NgtrYBWZ7spw6P8HqXcZx1YN8BHFHbPK++ct2cs=;
  b=JbPZZlmyTYN6fbgt9POx5tEAunBqTlLt34IdAZBK46435BT1GDCc/iN/
   0FJ5Ki2+nrPfXb/kLlbltKY32YLk6YGnIcSF/IjZQAOcpxd9rkP7DNjiT
   cpjny1alYI7Cv/Ox2V/95uosaSRycAT3B0XW2G1wn/CqbZ7hmW4HvvnFe
   OeRmVh4r27D2G10DN6T7bgj9TUax6y5fa8ad+wwrtjOpLa4gex8Kl1Cfx
   aWJsr2dO5igxPMGWy+/uyl/z0poz92+j9N/zZJdatk3+gfjF9duhOSLGF
   8eFBqoY0qLoDfaFZg1Zf3ghm/89PA62yckvgh3K/sUsTX1fhXCq76EVgu
   g==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654531200"; 
   d="scan'208";a="314628021"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 23:14:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE9gh6V5v1E8yN3n1Jy724LiJVgWcXzBtK4CHh+iCHhnaMX9vL2bQuasECwn9cV9aFM9beQi/1zZRdh/V0sKkh+XhYeDIONIhjX0GRXF68oOM8gdlxI46YI4cHJQvimzrwqn5FrQRWYYJf5qBq5tpD78j9g9xEtwzwdCyf95G29YXZFsB8MpdTNQSSn/vuzJJogG9GMFo3epIEPi0WQ0O59Wt4MQ8djJH5+saPF0YsTpBUfA2GQUM/2cOpLQjHlUqF7ZUuO4ydtIqe3pHUiEUT4UUa9Vm8zf84rFyRqA58lFjjFjmcqlDuZL0JhyNYe3ZXJbBqM9DCNfY5HD5p7l7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/B0AQ288IPGnCTtGDoo7liRFtTuC3j2IOWbz4tMd7o=;
 b=EOBbHTkoQcimt/xPNT3dn9Ajw4fMq8sbN2Lq6T6kGLmtJuzeSVA9k8J+V31yjFQrLJsUuszi3U7swOTebG1Qaklyn/yvpj8gOslcUl6uhgIo2TZRE3ODrxjtHuGEo4E+5pW65lMVilAXq3Lh3QyTT5lDQOyeWXJce/YCJNTYDlKeIzxFXFlYZrbj8hz0cOYGhbvWJb2i0h2aFj1iyeUPUCgEMCY/V8bXWoA8Wi9hNhVqmMqOdU4Z3HWZ7ufZYICYBWqecjS3i1EoNcmxI0wYLIg79IBhShN82n3OzBOmbhF6E9U6lnWl6PZdrupv3xiNQJTVXiLOVwVSWJXHQdgBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/B0AQ288IPGnCTtGDoo7liRFtTuC3j2IOWbz4tMd7o=;
 b=oT7byvNXYjA4IjcyuA/6N+8UkG9mbDNudht3LX0VYASngnohp8jLHTFHQO7MA5AYGfgm4h32gqmq1e0gaZZRSrez6TEgCRo4zNyg7yG0GQgo6qRSPQwfW5o/buzeKKpWIllxknvrIZ41qm+0v19DrKzrcffvtN53Zyw7IHoEe3A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0333.namprd04.prod.outlook.com (2603:10b6:3:75::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 15:14:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5588.015; Fri, 2 Sep 2022
 15:14:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix mounting with conventional zones
Thread-Topic: [PATCH] btrfs: zoned: fix mounting with conventional zones
Thread-Index: AQHYvg4bRIgu72z/r0OlcBFnUvoxzg==
Date:   Fri, 2 Sep 2022 15:14:06 +0000
Message-ID: <PH0PR04MB7416E431ABC6C49622120A879B7A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <0fef711e5ed1d9df00a5a749aab9e3cd3fe4c14c.1662042048.git.johannes.thumshirn@wdc.com>
 <20220902124143.rury5rlrim2hfzlz@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fee968f-6c96-4d18-e44c-08da8cf5c724
x-ms-traffictypediagnostic: DM5PR04MB0333:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mm2tNeyU16Bp4OgV6mGPHnYnpNDp6t1vvLpDx9/LXzv+OgUpdZngjTRZ8K94gtuaLTchH2zZvBrzGF8CZwFg+pZaHAQZDrq/X1zD4apTR6uobB50KIKpqcwwdgXcqunXldoDptz5BD0TQVzkXWpjNJcCeqa5r48v8WI9i20quTh8Y650v+PL0QwVsdsatTb3/ye3zdcnCTvNjME28dEYXl+qs+fZabZAYgDPqykYI7tUkpaVGifjOvotSoULWENxF8hKut4ntgkw2RzEtAHem1mxCmt4MUJiHqG0zu199Hc6gnbwoUTiYPApS8hG5VeXvmTCN6PUdhQ/jS6NR2m1lWhdldDRyBa0t9GVF+eoYq323YXHV+7Y82bM/7d9U64xIKujxhGRcWq1lzSkuzo/PzgCd99cShbPhUBCuP+ZdwPdTkBDCH29Q6kLVxbUR85Qmt8Me4tVcnvtrl882nyxd2NDBJgA+Lwkg0wj76VEefOB8MVD628fPcidFwyNTD+fyQNxPVg82//DaqXz/TnlqprURjb/eYsgOVw18iqmbv+3cAUT69y8QOD0MmAXAf84NYa7axzD3sfTkNS/2bBqS8qsjJkae83XLdot3gd/azPzE23/QP969hQWckveFw1+JyRQUkvG7u6zMUDJjAKOTZ13L+FqdggkvLL+fXk0dEidLi53NOA9b6WUp8mufuB7NQ/pF6OreCbmB2te/+9zTOywd+miC4AYnnf/oUeSYtv+NE5yVMZVcBpojvU5xyYmiLaB/giDFsE5D5+lexMUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(76116006)(66946007)(66556008)(8676002)(66476007)(478600001)(64756008)(83380400001)(66446008)(91956017)(4326008)(38070700005)(5660300002)(6862004)(8936002)(52536014)(41300700001)(186003)(33656002)(4744005)(2906002)(71200400001)(82960400001)(55016003)(38100700002)(9686003)(122000001)(6506007)(7696005)(53546011)(316002)(86362001)(6636002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4PEpONN9r18zEijNI8nygHSzhD+0T7y9UdHEN09j3MtXE/vIVpfjiN+jsCi8?=
 =?us-ascii?Q?mKIdlM1oefTmi5Da3E1eJjKSjPL5n53TY7ygOGT+PGdQAOOQrs3YXA9yFRK8?=
 =?us-ascii?Q?FAyjpFAy3Y/lhd1EbH9/sEOSvGEezW25efNEbbS9ca04pJrb6h2bty05fjPA?=
 =?us-ascii?Q?DYZYCr96EZ9T93EyyvEu2i594sLMdoDTG8eB24lWTOrBLBQOuHK/mHu6fHmV?=
 =?us-ascii?Q?BPw8tOaSD0tRn3gx49KSfMGAWzMxCKaGp2olIdUMd+3CV11+j9rHwbxHBaWr?=
 =?us-ascii?Q?+6Xs/yRrvbuHIf+ju8Qi9RXIlkoUv90v6HEuloHD5vYynIAT+T3mYisyxKwV?=
 =?us-ascii?Q?GZOmhz+mkrT3ah3sIsR5mrJlwQ4ZfCzRBlx4RXfKXgSk2qI9QTWR29xVquHr?=
 =?us-ascii?Q?xZxj1lcNh9XH36myjUL5BYZ2k2s5T8mJhhcUyWrGag4Vvga6iRcynnjQ1DXI?=
 =?us-ascii?Q?ELYCf1pb+fKVmvz7lS/OFlm2yBPVRrzYQ+sJvDEzdP5g0s7vNtQ+qHp830x0?=
 =?us-ascii?Q?lliqoH0zlR28rtLXb/F6F1ofvf6tQZokWWE3AvBebPMuPqLcfC2sSdtABYnU?=
 =?us-ascii?Q?5CM6PyCaNgZSj1qE/gfjgTspV/LVpAaMURf1nyrHhbJrR2jiXq6Lj0eIzWId?=
 =?us-ascii?Q?osj8JTEiMoWIzYxXVN2HQhOQEUGh5grpwUGMRWJsuWQdI2lLlzieqGVL5Gqg?=
 =?us-ascii?Q?eP7tnfscCOWa2vVsKQyj2tGWOR9O++EudHKcasVL7yf+OOkxgyp4rvka8ugV?=
 =?us-ascii?Q?ZbYUhhCHmgaoHYutW4hQVbAjseV+lsQoS1k25/P9fFj4u4TGQjV1786IBzsJ?=
 =?us-ascii?Q?OJG9NTCCFpm2mC+q2TtqPaHbUkmBeJyCKEqd0Rc9DoLWZ0ti6Vum2jR8gsMN?=
 =?us-ascii?Q?pvTMtqtL6u6zh3fXD2jJFA8WNqJ0YUgp07dO51+yBV4ZOdEpqL7NorG4VNle?=
 =?us-ascii?Q?7LaKBc+U5/VyPWXLfOpKKDUkuJ1TQAQG1PIjLjfGTUFcwsKmf8mWjasUlPxm?=
 =?us-ascii?Q?p0VKBVYb3d0sug2hNMY0I7Lbojq+Fe09v/5RF8oM+NCcrRnPfaVlJ+d74aDu?=
 =?us-ascii?Q?oO1JCekkc5AMOXmGGCNlH0BEfmFodv+LuLExrVJBdYIFijwpnXUYUo+M3KwC?=
 =?us-ascii?Q?2CWb9RcVe72imtALCTx7T8wzb8G6eVJGdcxX9JMxjsXcD19SLIRMIMesMfC2?=
 =?us-ascii?Q?xTTTK/0wAVdiPcjhTEzI4y2qAb2dPchTVBLeDFeWGN25GA9NNPSgvgxGNvUY?=
 =?us-ascii?Q?eoKh7fzZb7mfzFxoG/9YWIE+DP952vhtu2WBsL7V927ZZPWAIX7X/amMKNIu?=
 =?us-ascii?Q?T43yoVtDu9Ul78r1d3a8c3rMBfASw7HOItNoDOkbQkkF8zNLqL0KlIrltydW?=
 =?us-ascii?Q?F0DyObhKoNs6GYeo6AaP4dHIdjvuyUJddFPmk6/4/P9p4qJJPGQCr2VHPVDM?=
 =?us-ascii?Q?PC2R5xn/IC58c6l15Hc0zcOD+0yokBHtNmU9GkorLfi+N2QwsIGupCcUn3pg?=
 =?us-ascii?Q?Ea5QKbF7IeY7fobDCdXDJYkUsyxI4E/ZuztK7vUenOcVRdHm19r8VzXb7fh3?=
 =?us-ascii?Q?UZ0mt71XwLtI8iB4agosFunyZNkFiSb/E3bXt+7OzBEz7aUgat16Z4Fqkj1B?=
 =?us-ascii?Q?GoAJwDSJjmsjFssMc85PA1Cbed1DB+AqTrkph0Vh6hR0+B3Ze02djbgS94UN?=
 =?us-ascii?Q?YDWBRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fee968f-6c96-4d18-e44c-08da8cf5c724
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 15:14:06.1681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eEdq4SBc4V+LmctkW9rdNpj1URez5LgXXHvBjNCDAOzHQRm4BD5muocmmc4tzJN4+ptbaduOLpQGNXvuoJrQ5BBT3EPvRFYMRaxfNC+EG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0333
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02.09.22 14:41, Naohiro Aota wrote:=0A=
> Instead of duplicating the list manipulation code, how about moving the=
=0A=
> "out" label one section above? So, it looks like this.=0A=
> =0A=
> out:=0A=
> 	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags)) {=
=0A=
> ...=0A=
> =0A=
=0A=
I did have that before but didn't really like it.=0A=
=0A=
> Or, even it might be better to move the list manipulation part here to ma=
ke=0A=
> it looks like this.=0A=
> =0A=
> 	if (!ret) {=0A=
> 		cache->meta_write_pointer =3D cache->alloc_offset + cache->start;=0A=
>         	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_fl=
ags)) {=0A=
>         		btrfs_get_block_group(cache);=0A=
>         		spin_lock(&fs_info->zone_active_bgs_lock);=0A=
>         		list_add_tail(&cache->active_bg_list, &fs_info->zone_active_bgs=
);=0A=
>         		spin_unlock(&fs_info->zone_active_bgs_lock);=0A=
>         	}=0A=
> 	} else {=0A=
> 		kfree(cache->physical_map);=0A=
> 		cache->physical_map =3D NULL;=0A=
> 	}=0A=
> =0A=
>>  			goto out;=0A=
=0A=
That makes sense, I'll add a follow up and David can decide if he wants to =
fold it in =0A=
or leave as a separate cleanup.=0A=
