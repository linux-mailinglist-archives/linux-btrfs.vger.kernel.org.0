Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C3A587CCE
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 15:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiHBNAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 09:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiHBNAd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 09:00:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915CC10E7
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659445232; x=1690981232;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CLuOmT9tm7qTaGiyL+mdjX9XS7F8bAJuKOm09XbJsPY=;
  b=B9Jxjau2puvp+8Hds3XQup3UiXPp0mcmvskfB3OyVRu7VRLp7WHWwIxW
   iQxdXqqZG3e8KMZh2yX3vZfl/EexSrSqX1TFSVdHS2l85lA2hXFrfyErJ
   CdHq82F6IsSU3I+eHVUWURACtAHhjU4Z/gE48ODOZ4cOsRW8ULCYJtj+7
   vlKa314z/B4yPZ1UNJZEwq9lXO4Uh4MPHyTd6fj2sPrlZHxMHqw2vutp2
   tPqW3m82zugtYtSgbKV+8JyAokSq/qy7saPL5EBdZLj4nFEMbMwe7tCji
   L4CAw+LQFPYaXJl56AFjXGfSuJLC0ovhPoxaCKdP2Rf7u0+oDaTxj8FLS
   g==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="206108764"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 21:00:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDuUjU+ULvqH9VbxcsRdDFoGTZtoFHkWLF3oXgvmiLM75MS8fAhVq3ghfMcLKY+09IwIFsJLNHXC8GRpDMtVgKCdDE92l43FK6zUBZ2iZcLfRepEn+ASjUKIMoA2BVozASS/FgsqxIzlXBCCkm0tyV6yxz86DDgOx8vO6RZV+0XPPvsvQVNgeIF3npke8H8brIaa1dnE919t2vUtLJhwMY/bIqYOex+PgNGHsKhaf/XzWqYPuRehv36sX2545rPkEgirn66wJnOyuEATiP/054iSFrIb5VCSSQrYSzgDPFHIik+YLanfv2zDsDcqKlUnrF0U5en8TEvPNX0ndYzFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Zrp0HPPA3RqKUh1f5iTELvfeH4rd0uT/+bH4yNyOTc=;
 b=VurkLTfdTMmbmGRCPd7UULl/wOgIDLjqfiStH0fCFtM1/Lvp2LRt6KUlxz7ScX/l4aXljKQQGWCj3INA41kE/OeEG/7ry01e1g9fAhLNG1wivGzZawlqK2nviw3RgzJjPYPEv87al46IHPtJihLn71U5+MzN2X8HKCc6iKvGQpbFk96MvUkLQK1KUlnB6y4XCW2Z9JcY/n6THuR2HIEwyEZkdNtdqJ94TV5UbdytVffjS6WrXFFzXD0UM7JxQkX7FSCsRiRsZzjUL+Y2zEIVp6I79I8tA7jIX6QM1ceEpQhRa43bdFwZuS97pjWeSbbI7NvNl8drACmrbv6+jr4VMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zrp0HPPA3RqKUh1f5iTELvfeH4rd0uT/+bH4yNyOTc=;
 b=PzwAPlhhcIbVxkOsYFPS5/bM5TonNc4SBLilXLhPc4kJW5phYfm55ZKvdmS+48HVwGSnIM2wAKqumHwuTw1q9mAvkgTezhzXcWCdHp3SSgNjg7CbBy3+kbJYiKhRhCeQ2RfHXEHcRckE3m2MfKNYlXnhOw9gbnRk5NeWzlIpqdM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7789.namprd04.prod.outlook.com (2603:10b6:a03:37e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 13:00:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 13:00:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] btrfs: add checksum implementation selection after
 mount
Thread-Topic: [PATCH v2 3/4] btrfs: add checksum implementation selection
 after mount
Thread-Index: AQHYpmwVkU2UIe5au0ukWfiqzwyBoA==
Date:   Tue, 2 Aug 2022 13:00:28 +0000
Message-ID: <PH0PR04MB7416F25B2C1D7CACC27F83859B9D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1659443199.git.dsterba@suse.com>
 <cc590040e5393aad0294e3d7c592de991706cf2e.1659443199.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 315f4cd6-b7ea-402b-9e7a-08da7486f973
x-ms-traffictypediagnostic: SJ0PR04MB7789:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lo+jjhO/PA0wTOIU5BoV6jmN8S210KX6ubM9KBl/5MIs+pVZAqrChgakHnWvf2eipE7zGEWhpG66tWMNjiZlVDkKqGAKpc+mpDg8IjsTeYDzSwur7WxUHJORJWm5HYk/5JJ6PRo3BNYqYjo67sQenrvBbSDpLKXwwQaepXEhDIQzALprucGPD+gGEQNOslhtYKnzVQIR948n+STwa9buLEfw4Kd0lTQbQk8JNZ4qagHufVd++PTAOZpn5+im4cXzvg+oUeNOxhyX49QaoFZa+sScydcWoo8kgaTdr/TaD9TMr8TKfHsVGZ/rAQmBpIHFOJZc/dWYqfEAdJnPqKOu3aQdiiDEoTpAJ7uPHKTq5WbjfSJN6NeU+yFT5QSTG1WBZUPQyazj2nxQ+XG79k/TKYxxp+cGMNcFA2Tx5aWFUGK5YvAZ9aGQ+Fk3Qgn/aEn2TDP1b65BR7B0O5RpHS32vHVLCLGZ6DTNRSFLyzAeaagKhZWtp/pdP42xDVHCP+3gf/c6zkbp8Zbs6Rl5edtobLUu0vNf2JdKD5Sw7sbH5yq7NeYpfX2KW53k33o05BcSM5yfzp7NHVMBojUTqGDVQVKHI372XAxS36TB3AlTiXwkIJ9eRb0AlRraPlmDE1nK4X7e6etMnrAOUDNqf3DE2d/fVcE23yl/FLBieOLdiH5PZgfCukzfj4ueROLEuoNzgIjaO7KbwWGOr8HPGDUlwdHqJqT9yzXxlt5oG6/xGnr9fL1V+4c8URzdejkYsIsaF1pvzI8kFXjlmSFlxPtnc2waFdLHBCEdyKsoJ6uzYFJgtC1PtEaWJJUVX1yOp5mM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(6506007)(7696005)(53546011)(41300700001)(316002)(55016003)(478600001)(9686003)(110136005)(86362001)(71200400001)(82960400001)(38070700005)(122000001)(38100700002)(186003)(4744005)(91956017)(2906002)(52536014)(8936002)(66446008)(76116006)(66556008)(66946007)(66476007)(64756008)(33656002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q8uJgWSPWrAJp23EIs2EbcLgo2+62adQMYTnvawD3EcWUxRHQYPuob6t5m2j?=
 =?us-ascii?Q?0Jo/XNPxfBaHTaLEthiZDNiZNWXUK2fd0pZQ5C1SpI/MPGAlIJgibASOVWoB?=
 =?us-ascii?Q?qFkHX4FVFrrb9gJ1fQ1Cs/pA/GzTDsLFkYtvLA0mAr0ZzJLLdCJCsmEg744z?=
 =?us-ascii?Q?TnN4NMIx5sbRaJmEsD3mojGeSgauVH19GRDg7bYfM/D4axzkWfZl0PXQXJ/O?=
 =?us-ascii?Q?KHeMCxjssFp7EvBOF2nyIhRLRit0v3CMluHgdnK+l/J8O1/20XJNY3POyLwh?=
 =?us-ascii?Q?tlPSUjaPwqBPaynrJkET8ecdXxfgqz9aQcOVNqrgRFyI95kjDIPVGqDXzC/S?=
 =?us-ascii?Q?pxloh4V64VrUlhUQR4Y/m95E8wmLcFqWYkhoe3Qgvhmo13j+dgXRDAUh4FrW?=
 =?us-ascii?Q?b7Df+cDhMwgyZ8+NDCnhllBHIu9R2qNkonq5j+UkpdjZTCIfrkbD8StC2EF6?=
 =?us-ascii?Q?RQpvMz63gjTEnkd/vSN+wJupvfsv5kqwgn4GXAvG0nl9uJXVRVSkzfDOsMI2?=
 =?us-ascii?Q?e08JGjR6pwbcH1J5Ogz2nWb9jnX4Wq5+4m/dJKTw51n9vKpW+zboZeCGwoKB?=
 =?us-ascii?Q?mkEqAhM3tT+po70QRVp78UWv9Ko30ZBE7Rw1+y0/9tW/0l4+iRX8o+LLD3ed?=
 =?us-ascii?Q?aZXjqxFPJQz8o+zyZ/WtwsRZx0n5IE+RFrMF8S5r8hhz3MpOmnIbEAMBkLNK?=
 =?us-ascii?Q?PGMSe9EFacQpoesikQKKFQfjdOZ5RE3PFL1281uYd2IVS1kcb7zb8q1nj3fp?=
 =?us-ascii?Q?1sJvP7OTBw2vJmHLdwiT68XhrFVTgSQ2dJfujDe61UEi1cx+uZiCGoaoqL4W?=
 =?us-ascii?Q?V9uTq7zDCNlkuF/xNbSPLQjy3+2wnNcqGgSnN4UT2i2QMuUwYiWccCYABgwk?=
 =?us-ascii?Q?Xph7GYsyv3qMaJb+JxdW5hn1nI1rrucoA+3X64PE10k9V/kR3JNrN3AR2B/r?=
 =?us-ascii?Q?QNj4C45N3MzCuG4UtCdEJKAd9tGD89nEx7X96+7ceLawnlpXq30PptM+yYYC?=
 =?us-ascii?Q?7CTrVA91IsCOoNdDrnZgck6vii3WexrNDlju0o3KoS81OzgSFgxXaOiWm1ia?=
 =?us-ascii?Q?djdYSXfswV9QQrQ3tYt3leSlpMEa9k+jH5ZS5bvuELWxPImMj8Q0tB+cINJZ?=
 =?us-ascii?Q?x2rCvdCLqN9A1M3HlSRxARkrvel/UdZI3PKihkarhgQGWrkIysP3fynvKbGd?=
 =?us-ascii?Q?v/wmZoPadZ3lxpHi5jqY6+ywE/FjSY6ULZxun2PzDQmmjFCgWesFafDgyGEj?=
 =?us-ascii?Q?16sQnVhBHAivykYfo2YRqOMYnt7bNZ8KxXergtKEGQDWJEM2Q88ygbAa11nb?=
 =?us-ascii?Q?SZ+fIBCZkZsnAmGBrfgveHVSdoZ6hzgpbybvU0ClYjwWipq+/9TFvThoeYfg?=
 =?us-ascii?Q?RNRFvkqiMktMixzmTA5PdEwZaRjHybB1urg9d1oAYB3P+6OTweBPIY+XyJpx?=
 =?us-ascii?Q?nZmXt8rMwtC8JU7BBuHMjnAoSFMlhHm794x0MXIfV9HqM/ooVBpcDHflZfxd?=
 =?us-ascii?Q?jYvP6yJSlLNFOa24iHK3E/M0OWy1HMABDaxwB+DukA76LEYSOpDvUaRVCTN3?=
 =?us-ascii?Q?tFfQUyH2cBGirYAPUfJ+PsPIq9V3b+b1VbQuXVfKF2SVrSpNWov1zN4DvbUh?=
 =?us-ascii?Q?T8O84Vu2YDWgcz9Sn992vjpd6lH5TGd/xY5Z5YOd5fjzXTPzvtJn25xm4L1N?=
 =?us-ascii?Q?v0rVy0FWVs/vmIwD5e5rKTW08As=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315f4cd6-b7ea-402b-9e7a-08da7486f973
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 13:00:28.5733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/gqXDREqRKb39j2RUug21W8j6xBX9egI17c5rT6qc7QDwivOFDZsFKZSdMTLxsQVn+nkTZsiDmigCH0UKO55+LcnY8HbNk4pSlJcXtvM7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7789
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02.08.22 14:33, David Sterba wrote:=0A=
> +static bool strmatch(const char *buffer, const char *string);=0A=
> +=0A=
> +static ssize_t btrfs_checksum_store(struct kobject *kobj,=0A=
> +				    struct kobj_attribute *a,=0A=
> +				    const char *buf, size_t len)=0A=
> +{=0A=
> +	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);=0A=
> +=0A=
> +	if (!fs_info)=0A=
> +		return -EPERM;=0A=
> +=0A=
> +	/* Pick the best available, generic or accelerated */=0A=
> +	if (strmatch(buf, csum_impl[CSUM_DEFAULT])) {=0A=
=0A=
Same question as with v1, why not sysfs_streq()?=0A=
