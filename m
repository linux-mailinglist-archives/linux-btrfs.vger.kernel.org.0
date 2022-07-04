Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D397564F2A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiGDH4a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiGDH42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 03:56:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E99CA446
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656921387; x=1688457387;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DxNfKDQ6ckj9w6PiMXVYN1ZI454X6I6ew5a9TRENHG0=;
  b=IOmZ0xFl9RBomcQYLP4QtXZp+ibH51ZuuYCaorkJ7BAu9t5p6yd4sdSb
   Y6NOkVD+/hDmp9wRIn37bi471lfzWf4/6OM7ticJ3aVTqOeAg4w/SuYhs
   7bvYn4rplpuRH+LuvaZwufA7K/8XSvW1f+p6EoMToXDq9XmAzF85cm2VW
   ClMMsOgk+vSVY8+jJS4dcBnljGHwRFVFT+8YzJgKdtN2LJNW8UzNHJJIU
   1XVLdwP4ZQE7H7vENUwHr12SKVw0Wl/F/1Qfu1uK+0Dn8+aFdRGa4gGDO
   1NOmhxIe5ccnyp0H/KImN82YIiFfOo8ytmnEgOEMbX65J9bvv5NloKxr9
   w==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="316863187"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 15:56:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba70WTYhhDwPdYvpUO1cUEl6SIKhA1lrUBNN9VxIRvFCSQt0ZbM4JpbV4Jv7crAp/94bU8J/VBvpvbm/xCnbBmudlBd9luXdHxAMttyL3RY0uL6v6YLrCkMJ6Gpuxso5nHaRS4v4Zx7oSxFU/ybzw7vPvkrUh4jiv+0dhpzvho7dlzoYj0wYqMN6eT8/4R0aFytEossLgBxe0gGovQYscxSaMoQyIROf2RQ1qLaIEjzBlg4titn7HMD2yKTgtLpQ2Du9krsNK1kqln9cUOZX2spkMCTi1AKo6u/srNc/0ihFoZPN9guXZ5qoZCB6DegW/o558ggG1HrP/Ibbj76xTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0QaI7WLfqjKYnAi4BU/nbo2ZLWl2CoQ3IuEuJdE69Q=;
 b=limkvUTvYO6PQRs10U6SgDip7+zomrFQc4rZMLYOj/9glSo3ASd+EdxA7VZeqpxqclFJOOLM9gjl99f1I5FyUPn2ZQxuypUb22GIDpA936RqXzgu4rWA+AEOGnCtoGvIHbvKfxqiv6BdGiqmHuI1hn3TU+W/gHJUkTadtKVxQQ4GYpAgTHv5yYZIvJL3GXfOP3zsd7sPheRomnjEUo31WnYcI03ikPswWfC0PBd/7JK1zIs142a+9XbBFixw8bAVpEJ4kQ71QzHY9Y2KVl4pP620jschsmCMzOVCeJyr4BIXZrxDR13FJhFkXG1YOxY8VrxOv/uP4GRf2KtFXwygYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0QaI7WLfqjKYnAi4BU/nbo2ZLWl2CoQ3IuEuJdE69Q=;
 b=L1DWsn5VLG/CXkJfVRVOwnQSALuuTu3GCKxd3Cs9Qkfm6n1yYXs2VUthBFq5DfsKhL4Pg+fZv59axJtLmzJEki3C0RZM2CrAXtcvM1XOn7bHPXVRG5RqtVXmpY8CCdeo4a2crqlBI/naigJ6Jw1GVgTyXlPjvVmIOSNU/LnOJ7E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6002.namprd04.prod.outlook.com (2603:10b6:408:55::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 07:56:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:56:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/13] btrfs: convert count_max_extents() to use
 fs_info->max_extent_size
Thread-Topic: [PATCH 04/13] btrfs: convert count_max_extents() to use
 fs_info->max_extent_size
Thread-Index: AQHYj2LHSKlOM1Qrxk6RIWg4qQuTqA==
Date:   Mon, 4 Jul 2022 07:56:25 +0000
Message-ID: <PH0PR04MB74163C8669C9FDE40CC41AEB9BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <943a1cb89b84002b49b758fce808a36a50c195a1.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c561bac-11cd-4bec-0cbf-08da5d92b1f0
x-ms-traffictypediagnostic: BN8PR04MB6002:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R56seGo9eJVbvwkATZSgeg8u5e/pbKzxEzBk3U77EzuIwP5hrz1BiDdOA/z5NiCByOvtFc0433okP0a0Oof9ozeIdLl3FHh6jQjg4CRCe5ckSLT6MJJnW/bu45G1GOPcsRE868wVEulGLHtO0gDXcvB96YS7WA+sKhw8+sTsfiQi0ttY/qdXal/abl59AxN0OdKmZwvl8FGIF1+OXKMkuaiyjxaOhfVObGLieEj2gXyX6vFjKw9rZFqm8oPAp+szDbZWoC+VoODonknsU1Lil07YvP9KAzARQQpi7u3S2UAU4V4G5eUQTGp1+1mBsZvYY3V6pOuMlIeCsNxFecdRtraUHDimZqZ7Qs2kdXveHWFoA9aejaY5uTztf+hYafxB5Om+ARk2EgU5Udtd6FgyVwIK+/Tvew7lLAWz2DA9LZ/SxtpsiHKgaaQ5M4ebSITNG+cJTPtlkx12rEWpTIXxg+2QxDgfBOL3yrQM3Y8hi53ZdTsGvh1W2O4JYf0tTtQwV/YKjRhCU1rzAFpmMCxSnsNTZ0ex/apj7BiO6wUh6YWCmEv7uP9lYiomBTKKVsfnXSMYkyzbTuPl/W82eNKwmfd5ZGfMYKLvemzAwzSw4IE2dKEtT5X+4iTVuD09qjWaqwqRK59WWDzbhPIp+k3MhicgbUg0uGD5+aPD53VPaD/hM06DtrN0WGhZCGcgM1U+Ra5Km2dA07PE+Js07NCH6ypJ2ptqXkiF+0cjerdOj0C84jPquNRrcLlYpTfwtnCm79UU1wC8SlPoXV8HADme002M1T57MBouukK7ETOXdUwyaRXnm/DjmfCJNgmGX8D2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(2906002)(110136005)(38100700002)(186003)(41300700001)(53546011)(55016003)(8936002)(7696005)(316002)(6506007)(52536014)(5660300002)(82960400001)(122000001)(4744005)(86362001)(33656002)(66446008)(66946007)(66476007)(76116006)(91956017)(64756008)(8676002)(66556008)(38070700005)(9686003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KBoWxTejzopBcqd03H0TxDsipd4Qf7LSxlmDw2VZmRkvAM9AZ9wKp/xvZ8IL?=
 =?us-ascii?Q?OdsRAfLcJib7m74rauY6ceiA/FTC8Yck2ooSWt+wCnb/KENKjLicXlMsI3I/?=
 =?us-ascii?Q?E+djGJWDnU+F4XA7y9KSizoUgpuDtSX4jU/T8ubV/ZX8/IWTrAKYMGiyRfPK?=
 =?us-ascii?Q?bO/9hq62mPMylJkCq+MwSFkqwBC7bTieCDaXGghRJAjS3Q/TdyOp56tk4EoT?=
 =?us-ascii?Q?TSz7RrZeWfh73eTBO/cJ9Qn7sZWOp4ro7PIPvv/GoAGGgQ5SfcCcOZznI9pv?=
 =?us-ascii?Q?RmrdTWVDpqF8tXTUZTbufZMG9HyaHoJD34YsYzHyB4Eenowel7pcd+o8qHTS?=
 =?us-ascii?Q?3WfT0vTa9Xx0PhHSMC31defQmZ+vSThwGyHzplCiJhlTq9cAPRkbDyn12cfu?=
 =?us-ascii?Q?2QMbdCAIuJ2s6/ijfcrb/rw7XZs/1Vgw9ZDaV3Aylw/lkz+gCsiQDzAGR060?=
 =?us-ascii?Q?WrJwIAAsAoI3Fl0+5KedoPeldBeOlDxQd5vVFn48LyR5DzirGBqeXP7sGR1+?=
 =?us-ascii?Q?IG+Bd8RzLzq9cut3A00FxcGYfVg9u/HWKvBMkgnSWixkj1aNP6rt0oPVEqq0?=
 =?us-ascii?Q?VTF6EvHd8y9bJZTLEjJzkgBR0vMUFHZaNZziJRJTlj+SfT1c694uZJuw9+1s?=
 =?us-ascii?Q?aS67Pf53l0I9I5ec99jcGkZ0u88nhuZt5sJ/wdc2rBKwvs1I8kPCPGzJ5njt?=
 =?us-ascii?Q?Ce/6SYsTxOxV0oTFi4SFlDHw0OqQF4K4SXjoYz2sslLl8skCajg7+ii4bpkT?=
 =?us-ascii?Q?ULN8uyAB4gGGtVSA/mfXfLUWMLZqwbHHB+ImlsK/WD3+P8e8IXXdaiQ4ZWTD?=
 =?us-ascii?Q?I4Gh4TABFPEq1R5UFln7U71XZoxZeQ4TIlrIpRvJE62diY/twgH5wsOZVa6f?=
 =?us-ascii?Q?dYuYkD4oRl7Qw4BIdsIUWlrxN/0vlKMspE58Pb/cCKB/cpl83Xmc/cFjIIjB?=
 =?us-ascii?Q?Q+FVGaljzSKSR6grxkjosO+bAL1vTkderMTM9FcTW5ERDhN7VgBTE2dkMlBb?=
 =?us-ascii?Q?6KlghQ0Zaxv6fL5Fp9+5gyiXFGLEfykl2wL66HKQ9iJBGSNwWbvU1CP/hGRL?=
 =?us-ascii?Q?1SmZWVulFm7U/QcCKvqNIl3HyEEkquD+rzgrv1U9QN7GHSwhtPbw1NkEHyUS?=
 =?us-ascii?Q?rGI9EigvDDLBElPnXKfNJ/3E3Gu3KWOCJRrfvsAZb4U+eLMDegDp6X6/6HsF?=
 =?us-ascii?Q?s20WLw0+LkLSxmvknt+Mu/cySHNriXqvnHRwE2C+RvDa7ShUHU35ec1NpKef?=
 =?us-ascii?Q?rmJO7uBuAu5Waxlut/bk5YCm13RM1c8/aJSNCmTyb2l8CiYO2x1H2cnx79Yl?=
 =?us-ascii?Q?0it81n0RDHcaxop0G3kkowgHyQMldlKhUcbDSHiVdVYWF2LYieCLsTkJb8La?=
 =?us-ascii?Q?u1FK21WxKAEC2kWXHzBChKAkhoOU8u3sqENT17BHcoiKe3P4SCZ2BvPJwb7w?=
 =?us-ascii?Q?tW5t7PG/NdmcV+e2ARU8fmtAW9ZLJxj92eFJdapzZhXFyB6JKTOTzowxQtfx?=
 =?us-ascii?Q?vJFPSkw6Eem9GqAnAaD2c3AltXBmmUBSKEJkPd2vbq7FxdVnt7mT6xFHg1qu?=
 =?us-ascii?Q?pCKUgevyB266zW1X9GlierqrqfCYXSMGXw+CJ2TigwpRFRmZHEmMjbuYYJgN?=
 =?us-ascii?Q?gwsT0Lm04CuAQxZNpfgnYP09T7MOz5Tz2CJv9nwjM13c7daPggjcvZ7/9jc5?=
 =?us-ascii?Q?rm54U6i30eqAQYNSPg9ktzZGIKM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c561bac-11cd-4bec-0cbf-08da5d92b1f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:56:25.7941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+xn86YXvKjhbthy/PY+mNgFTgmIzcw8ufkX9S1LJ7oIsRXqVNJdpgnZSGv/SP6J4WkdkjHRab7DoGXYgqKvLkDHvoZU3MKuzyXqwThJBFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6002
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04.07.22 06:59, Naohiro Aota wrote:=0A=
> +/*=0A=
> + * Count how many fs_info->max_extent_size cover the @size=0A=
> + */=0A=
> +static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 s=
ize)=0A=
> +{=0A=
> +	return div_u64(size + fs_info->max_extent_size - 1, fs_info->max_extent=
_size);=0A=
> +}=0A=
> +=0A=
=0A=
=0A=
For the record, Naohiro and I just discussed this offline. =0A=
count_max_extents() needs to check for an eventual NULL fs_info=0A=
because of the selftest code.=0A=
=0A=
=0A=
static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 size=
)=0A=
{=0A=
	if (IS_ENABLED(CONFIG_FS_BTRFS_RUN_SANITY_TESTS) && !fs_info)=0A=
		return div_u64(size + BTRFS_MAX_EXTENT_SIZE - 1, BTRFS_MAX_EXTENT_SIZE);=
=0A=
=0A=
	return div_u64(size + fs_info->max_extent_size - 1, fs_info->max_extent_si=
ze);=0A=
}=0A=
