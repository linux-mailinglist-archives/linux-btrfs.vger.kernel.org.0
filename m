Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88A5572E73
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiGMGwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiGMGwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:52:11 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C0DA99A
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657695130; x=1689231130;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RjVURCgE+sra8dhMmufGHeXMOugW8ep4L+g29ANb7/M=;
  b=OMCYhrJmL6zlVE/OauRX4BVDxigJmzZK/bfmYF5T543CW3ImQC9g/TZH
   nv+xJ2wV13jAgGlrzALpYwi8x+RNBiFJ/9LeIvm5w64dNSePGpxH9aw0v
   RZ7XLCEDV4sWXXPtQ88dLsVc5Ru1IPrfQZzFAsCGZGOno8voefHKbAck9
   C5azOzwko+cCCiJChauWgEKvgMZM6YbNGCf8eyKuu0S7Cxu9cbTZqmhmp
   vpZVG/8AiTA8u5mxoVOy7hgb984vsfhz0/WzdY2tjs8Ot3aHvaD+CHd+g
   1iYDSfq73YD3049sz2BeFKkYcOK+Xh1gUUZlFzvGeJ90Q9nKM5kbuJSVn
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="317712078"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 14:52:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ8wOGpSXD8TOqZZNl9LlidXYN91H/hDsULPoaZFQhewsYnG2VM1W7ah2hY0DiaRrBX3feCWFbR0vu2kRFhwFJyzC78WKsrSUDmvJ2l7ZuO9qgi51bkDKFgGFHcdbfHpDmzOBfPryblvn3Uwj7su4awsI0YmSH0W1UVlyZrN10yA3cDCxWJfLzOYb7uCnWUeN4mKccKbNH8GBGkfK/hhK0EufbDlcoMGN2by54SKsTdG/A3pcSNhqsRzYYYZ7cFqF1tcbNYuFhquPcQIHE/nAlyrFaPb7UKdIP2QSrX6ka6lIskkS7bNH07LGbRect/Iof1r4c6TDMR/GGxswzCJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BREuSrSb755lSWaVDl3c5zUVcLa39RbWcclbcTbo5ng=;
 b=HmD4rd80yiZwv7cxCdjYlhwtC+oUgBikp5hN3pwxpq+18gq8bUsARlMF8z/zcRLDL2tvh/wLYVnKGedGRGVvCazFMAIb4M5OTHqm+kT7j2gCN1ZilqQwuccV7EQsIIdLnEkdZrkDP/7FSgiw4cBs7Pvg8XEQoYPPiySPs6tXf2eOBm4B0hsNC5P3B8TVbIFkWUJ6K45p5ILJyJrP7MnZVOmeADN2Z0XnRXtJY5SU5XK82PrSfVDHkq/5iW694k/A4Nio2HbLU3dGLkPe2K0RMBO5KEeBK28ilK6ThxqwDqjma2A5CTYnalQK5NpfRGRomWzQ8GKbIfKl+DOLbgrFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BREuSrSb755lSWaVDl3c5zUVcLa39RbWcclbcTbo5ng=;
 b=vN5jdF+D4qjumqWvcthv7vE5V8iTz9mhOmvt30ExA7s8lob7v8SPNQo7xWPcg59lse2P3f9OxcofORst/HfmDO//J2XoUuEGz30JAeNYbY/nkg6FmipjVCFa9CTAnpateWx1++2KL+S++/nZ2xlKtP7b9iJ9JczLOv7NS1R8ZIE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3893.namprd04.prod.outlook.com (2603:10b6:a02:ad::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 06:52:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:52:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/11] btrfs: split submit_stripe_bio
Thread-Topic: [PATCH 08/11] btrfs: split submit_stripe_bio
Thread-Index: AQHYln/MDXBrHKhcRUe0tU5xWuvWaw==
Date:   Wed, 13 Jul 2022 06:52:06 +0000
Message-ID: <PH0PR04MB7416408DCE02771612CA034C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-9-hch@lst.de>
 <PH0PR04MB741681A236D9F0C0F834BAFC9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220713065027.GA14237@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ee818d6-5c83-4d02-eb7d-08da649c338b
x-ms-traffictypediagnostic: BYAPR04MB3893:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQZlCfFrHnpDBvzST5BEeUHMGwfriirA4YTFYGSjJ5Xo/9bFRiFeQwl82y6Glof2S0f+EHNX2ZIkjis+g5iVKsLjM1cKc+wJMKsiEmj55i1ud7z/WF48bZOfn8ad7tTsw4X7PO+QJKW2FWgDvksz8Vg8gU8xQFFpLY3eln8JtXIqlAPktHjT9xCjhcF8Y5TKRvx0NkvEkljOcbsrEYw2Ep5HUVUGdhxoE3oMvz+Ri2Dot78y2yzAlWAhykLo7K7hczRTyH9rF93uu9+yiqEMhSl1ZCwt/x6N6vbVB82GNuBvWpzoKZqOuVFxdJvynbBlSV2uKbXCZZ7Te55JEAzAEgs4RB23PORdgLOK3xWZzJMZdOKILmP2Z0/eBsRIJ+Lb96rvlv2Jy3GAD0a1GCCw6fCUCOrhKYi6+9G/ZwvBj4itP/VO/hI7j0ByULIFB5EBaf6AxlnX9EFus0/ZbQtq9IQZtMxiofH9ioDJFd5NLha9TNr2SMdgYixV5TsP9960jyeftweBYpuhtjBLnSJTp9HKQwtLbV2XKCq1NI6snF0m4qCExsgcbFuIsZIZF5B9vRKWe7f4e8OwkrYHJPokmwJhqT1gSuSsO9VaY39F8AXjTvcp3WPnmNJ7H97RPqnlZDkKLtEmAXG1b8v4wVO4qvtw2zpyxmPN23Q8fxoz/r5+8LZoBG9PCqGPIp2Sk41wcI2Ix1c34tRglUBAU4pCkbB15/K3+hlTd2nbIUcnL6LzqVh52rGEaEw7qYUXhSP6jdO30wB+VAvsCiV9wULshM8NP9VM9i06AI9oyleL0QRy7KOEpqrxNLF4nEaY3365
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(186003)(316002)(6916009)(478600001)(6506007)(38070700005)(7696005)(2906002)(83380400001)(66476007)(8676002)(4744005)(76116006)(66446008)(54906003)(66556008)(41300700001)(4326008)(66946007)(64756008)(55016003)(53546011)(33656002)(82960400001)(5660300002)(8936002)(91956017)(71200400001)(86362001)(26005)(9686003)(122000001)(38100700002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4IsQdO+JVEJlSZocesKbgsCUXwSpJ8u9YW3ENroyDwj6dMKEALSl8RKBYHRl?=
 =?us-ascii?Q?tPJcBjoSX2PESdiUi/D7Tz+NGYdBhyeO3G83yFb7pS42+4+3MU9IfDSNBGxt?=
 =?us-ascii?Q?2OdYwoLdKnEgyFFTllSSTnl3rp4S9dAP2E1pBUND5K3n6HAsxIdB96qhBdz+?=
 =?us-ascii?Q?oytLe0z/FXs5uCPyMtr9JtlGNICoc+IKOXVnksHQ6bUIujwb+tG37QcOUSlV?=
 =?us-ascii?Q?GdrRFfWN5n+M4rZZJIIvvCLCv/7kfLfyFvFXvzWVOm3E5Q95ERA6vJ++Djk+?=
 =?us-ascii?Q?W58VJEPXMNbQ9rSVFu9xev83b/8agMGVLYUwsvKNBGqNY9OUg8QejUfrkVLz?=
 =?us-ascii?Q?BvcO9ueHva0Aqf7b+mY9DYz2Z60EnH3MFEnjhFm+WAlPCCYpbj3GKhh0l/3T?=
 =?us-ascii?Q?lRXQOnsFTMkstcjIjkPbGlO1gbKyVQ5IXz9o2PZYySSDZR3wfkCr2Aaavjz2?=
 =?us-ascii?Q?Uk183QO9c9riJ9q7elRip3YkE98UKwgxArTAtENCZx16dPDkfhKoNgtE9mFM?=
 =?us-ascii?Q?Nv9SiUt8qGboDMdYmhqr3SKkUIv7kAHo4/xedyDnQ/0Dr1AFPbwsmB94sLSy?=
 =?us-ascii?Q?McnixafLqo05pOB/gEAvpmP5vYwuownTkIE44UCNOkVZouH0cipWOpItC1mS?=
 =?us-ascii?Q?YPdeDPXfRir73iy0H4/CuLqkgPi8V6OOCAAkWAOf+h+MT+O8iO6c7dqhKx2h?=
 =?us-ascii?Q?doELUsM+7UYbmffhDC21setbu1J6iynYlQvti19boBs8tG+8mzTpUcnGk++I?=
 =?us-ascii?Q?3ULe83Oj95WUhQfDvRyYYyBszxpqBiWNNZBQi71/9sqdz2dThJFTZPnW2g9b?=
 =?us-ascii?Q?jDq84YrZka4X6t4MtQydU0+bF8RIJOBnaYm+3DG2K5PKjyqB0RG1oIwfLW+/?=
 =?us-ascii?Q?IThgU0LBy8LkiVNoUa7qfKZ66NK/WPaBW0nnahuR7pD0mD3gehwoRDC4Nli0?=
 =?us-ascii?Q?84kgBmwZKIyBLCCQLMC34BmwLB45/KICzmohr13ey3HoQiFRI4/+S0L1DWO9?=
 =?us-ascii?Q?EmfYl3V4ufokxviV3uMqcm/0FJiha84v8ERJJO0ppaOXSamGjTWavhJbhyXN?=
 =?us-ascii?Q?Cpuql9R5UCwbpqSoz/0HIi7H7d2+Yher+YWoad4gBKlNK/K6t9SkhHE3Y/3o?=
 =?us-ascii?Q?e+aSEVKDE36piQfHJmPjAfuQesVGVsUJ36fsNpVOmBFU20vZYHaXjAGVfVx5?=
 =?us-ascii?Q?jPicrt+73I3o58ZYe6QmxsPKMZ8GAte5CKoLhnWhFMXbrk2NtGcVjZ8hT/pn?=
 =?us-ascii?Q?WFdafIYk/tHzibYC1AKrIOjKSt7z7h7cGJBso99nW0HXd9R6R9nNTnvRAQsX?=
 =?us-ascii?Q?Q6GJXO6ER9xZ/SufeLcsPl119WYh0n23vIMClnBiM39iXfFJunwkCxdCtY8w?=
 =?us-ascii?Q?xNbi6CAPvT/RXOX0yQ/TLAWMalEzuwRHOJi7IviO2tcagp4vjkWizF8iZc+J?=
 =?us-ascii?Q?p199VtpS4mN16gVclKnYj/fr9vgf/KG0DbU929uYrjvFqJ+Py4YX4cpBufoG?=
 =?us-ascii?Q?9Qw1pRWlT79/QQ6WiBLCtaMM0XUBX+OH0Iu9TRYZdTD568eCM8gDXaNR8DZc?=
 =?us-ascii?Q?32Tnq3zZ83C3BhOnLGFLaJF7mGPTZypeJrvH0tiNuEn1HMV6n78M4zWhAtB7?=
 =?us-ascii?Q?qQDl1vJ63RW7VWDNEKiuVOo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee818d6-5c83-4d02-eb7d-08da649c338b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 06:52:06.8673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hUPDYoG/8QSMLFriwZOzsF8+Uoj+8y8hMsui3PkyteylGkILIDsTGd2VuACVADyxNfRMtYiGPp3joi8RFgxz3bMtlDy0SywAW2UbqduM2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3893
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.07.22 08:51, Christoph Hellwig wrote:=0A=
> On Wed, Jul 13, 2022 at 06:46:41AM +0000, Johannes Thumshirn wrote:=0A=
>> On 13.07.22 08:14, Christoph Hellwig wrote:=0A=
>>> +static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio =
*bio)>  {=0A=
>>=0A=
>> Nit:	struct btrfs_fs_info *fs_info =3D dev->fs_info;=0A=
>>=0A=
>> so we don't need dev->fs_info for the round_down() and =0A=
>> btrfs_debug_in_rcu() calls.=0A=
> =0A=
> We can't assign it here because it is before the NULL check for dev,=0A=
> and assigning it later just to save a second dereference does not=0A=
> seem all that useful.=0A=
> =0A=
=0A=
Damn missed this, time for another coffee I guess=0A=
