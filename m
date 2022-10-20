Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D3C605738
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 08:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJTGQc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 02:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiJTGQb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 02:16:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752FB17A95B
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 23:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666246590; x=1697782590;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=c8u1C8kC92iXWiU1Zaj3kYdjqunNYBoHQLnOTMnBsr7XDgXofyIBvChu
   VwDI1ED4PDK4yEbYT/SDdxIpTknbey8W8Ph5mtr8eWw6ab6GSpzlnIcpe
   nmzoXqfVwCXrhDh1zbJxVo6eHEcImCf+pORmAUJwfDKbX2v8THhmXQZaF
   xWdqrLSLfNBmBtn0IBaOCmf5oI+Rfih2b9KNuhOd7K8kmnq1v+n6h2by6
   YgCWTadzY46TDV1Ymrye9u8ctNlDkxDSPrKVxy5AIF6TaR+fiOt652aR4
   qZ7zJyAR7Wg8DkjkIBpB0Fo2UMP/hMu2Y0GTmWrvS+v09Wy4prTrLHN4M
   g==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661788800"; 
   d="scan'208";a="318620599"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 14:16:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6EQYY0W7Nn1exMaAA8PMVOMxcmdpHuCRwkon+IbXOqwkMSj1+mceNdBkt01cqE78vHyRmA869htfDaC2SmZK+ba1s17HZgW2r3Jz/4cIr22a6ugJ6BaYh5sEWEECJr4I1hCwxuGPME80kDvpfFqUp18oaH6eVQ2PMgD/uAFpLqOCx2tM1o4YqUUt7hdyDQbJdNRqU7rQIh6p2ktdw7sBusUZZT1cyAoqmKnGO4+CvO/y3zxO24LUmPHn+ExPxzVsCUuKbRNx3urU3v6wjDWofdGnO4rWrtrylawrjPsphmlPKj5k1IcPmX5CtemKDuSUvE6ZA1NWxiZmCKCOTjFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WTawJtiVl74/5eAjZXSXv1KQKWy1YInaiNfudt8lM7pPb/HAjzqRvMpNLABSSkKRket7boPAxbTG8hwGDvRPn7fo5wZQKUmn9DjztBghWqXNCgXl7Hosg4bntJy5/VC8o+c25yJqeW0sUiA7SvNs2CFPFFt/3EXp8j1GYX552FdfIwXUev0RVdAtsB7qHc82nupHxoV3EQHyQ51EEnT4Dil53lrAhKSKjXttSGpkJoZkBcT1wc7877Am3wJgG8diuTsTrTEytSH1FfXWSbQ/gilUoSqN//SskkBB2XDiTqMeDw0jQ6XlD8nlSqspplirpGp4d86YERbqSnpYvLohlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fKX1TwpPMNxr3eBG63to/IqFN1fJqSu8g/CxG/bfR6gbonhW1nFwTiBp3z7ypGkBwwF44MurekhIYte4869FCui2ulRK74RD8iB9UwhKG4+MO3QF6NIv7CDpeV1jDkSTp9fXz9FBRrr/8w742WjotLybD7QXyJNyp9H5708RcEc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7664.namprd04.prod.outlook.com (2603:10b6:a03:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 06:16:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 06:16:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 03/15] btrfs: move the printk helpers out of ctree.h
Thread-Topic: [PATCH v3 03/15] btrfs: move the printk helpers out of ctree.h
Thread-Index: AQHY48s3frKgJI6glU++oo6dnp4PtK4Wz2CA
Date:   Thu, 20 Oct 2022 06:16:25 +0000
Message-ID: <5b1ee04e-6bc7-bc0b-a763-e5c57102ed3c@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <c69a4810ed1f317b3a8f26fac4fe13750b6969ca.1666190849.git.josef@toxicpanda.com>
In-Reply-To: <c69a4810ed1f317b3a8f26fac4fe13750b6969ca.1666190849.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7664:EE_
x-ms-office365-filtering-correlation-id: 5ad26387-55e7-447d-474f-08dab2629e22
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1B5kF54MD0Q9MrkmNblrzvxGPjUNZPpkp11RRoTKQALZS3p99H78tk37fQe4i8qH2DFvOL1VL5ZZimiNy1px2vQtoYb4KhJvG6EnGvRiBuThWT5rK86bsBK7xqexVpZuYTyaycNmCXd28AnmA7EInHlFXGd3hZ86MiicdpJ5Hpcs0ApX+AnKxaQH+3xps9oUrif86X2sLjMiLBF6h4ky7TJHJd7VIUkXiFV9RQ87YfF8El8XYZW6KberggiwE492+x0I4CyfE8+w84pcYDuucGqpRETl1qNNbJo+mvVtj0XDKizaokcd2RxAH187OBmOqB5XIz0J9kQGrhK75KDPdpBz8dzHS8hS0OmvlQFKIo+N36o/I476vadG/m1q1e1OncQ7aM9xlqrafCvdX/jQujqZJ9+QnaLVabADaTpd83g+qy7TuEFwS+sHPq3ZWHfcVRS+oM89NSQv8WGef0i0gOl5Ix5PgLIjChnSWEOx3iB6OZz57pAeNl8yv0aTeaOsJdLvBleCI9Wt1qyQ/ze9btnF1DIRUNh9dfyWInDwbV5SWK7hMxW5kE65Lv/iXSx6tZa4bgwWtko5ej67XjUqZ5o1KpZu0j6c/9rfssKMYy5IKIEkzN8xSLmxRjrQKREKVLBR1BSEU2MTNuP9kR/TZe4BZ98IVkOrpWpTGY4Etli73OTYd0qAZ5hJHk811g0yYqUFgC0Lx54FcwlOMquT7BDOunenSYuL0i7Wj3GrIBCD88NYcC4yENaX0a412ldblI64ycFWtjxp9jLnLVybqp+rXV30C4TYr/4UZbcuYCUeTwe6BiUFseuMqTLaHKQVhA6ybcoQDhEFqIe5HsHPjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(36756003)(122000001)(86362001)(31696002)(38100700002)(82960400001)(558084003)(2906002)(38070700005)(19618925003)(6486002)(478600001)(71200400001)(41300700001)(316002)(66946007)(64756008)(8676002)(66446008)(66476007)(66556008)(110136005)(5660300002)(76116006)(8936002)(6506007)(6512007)(91956017)(186003)(2616005)(4270600006)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmRUU2YrYkVrd3phZUdVQTd6dTdRaTh1dVRMbmlKaGFBemtxL2wxay9uRk90?=
 =?utf-8?B?eTRDb29oZ2g1OU1CVytnREt5WXlNTjBEaWlkQ251c005aE1CbjJaaUMveGFB?=
 =?utf-8?B?QnRlNWRKYWNGTW95WjlLU2hwRnRkODBlTW5jemgzV1l2LzRvMmgzVm5MMXk1?=
 =?utf-8?B?TFp4N3A3MTFOWjJDV2FGYjVtWlVmMGpoUHNGR1VwbEZvTXdOZWZVdmtuYnV4?=
 =?utf-8?B?T3lWTFVIcmdGWkJQM2t4eHdoaHNuZG5Edzg4WjV0V2ZqTWFpVmoweHNTTDRQ?=
 =?utf-8?B?Vnh6RWxwcWdUdjFkY3RZem5FRDl4UEZqSTE4WThGS3pyRWNNLzFkZXpxL3pw?=
 =?utf-8?B?N3hGSlVKTThGaUR5NVFrUU01U21EWk9hUHRnc25ZcWQwRU1pbnBJZmpiZC9h?=
 =?utf-8?B?Q1FORDlhblpPc1MyVzZ0eHV2UU9HTzR1V28wS1haSjVqWENxTGlVUVMrZVZI?=
 =?utf-8?B?QXI4dVR3Y1BuWnJyYS9DQVVKTDh3NStlTFV6LzRXTDBSUEJOcUUvRlBkelBs?=
 =?utf-8?B?UXdIaUlRWkhHMCtnYnc4UG9ET20wTXV6NG1TckpaOE44aVkrWTRzc1FJMWx0?=
 =?utf-8?B?VEtsWXhhQ1ZtYUxwMW5iN2E0UnBrclYrdFZ0QzJURzN3WEtjZUdYQ3FPcjlv?=
 =?utf-8?B?dVZHZWNaaDdBZk5weFkzb1paNnlyUEZHZjJiQWlZR3ZQMmdnOVRYL1hmLzJ2?=
 =?utf-8?B?d21VdDF1YWxOVG4vbWJlVjZObDZlK2lvRThDNVJLQUsyMEtNSTZNaHpKUmUv?=
 =?utf-8?B?Vkc0VHV2eHBNSFV3eVM5RlB4NkZqZEQ2QU5iT1hUZlI4U01xZGNUUlhpUWF3?=
 =?utf-8?B?bDJ2MTlKbk5rT1N4d0YxMmgyU0p1eitKTUNkOFRJQlM3Z0JKVDczbWZMelhV?=
 =?utf-8?B?TGxuWVNGZE9mSy9hb0k5c0x2Unk5RkcrNytoRWlFOVpKemE3bFRaV2VoUXo0?=
 =?utf-8?B?UWtlOGxXQml2bHlvOERtOTVsOFAxbXpOdENNbEFubjhhSGVvYUhNQ3A0eGRE?=
 =?utf-8?B?SnFORk5XU0hnR2czc1dTQWRiRDBIYjZ3R2ZlM2EwZFZLMkw1MlJzZXFyZGJX?=
 =?utf-8?B?NFlQWkE2YVJYeGJmNWgyc21GWHE4L2tESVdBRzkwc3JNY2lETzZPR2FsNVgx?=
 =?utf-8?B?bzludk1QZlBpQ3hPM2VTdklpeXBvU0JKcVpuU0hndTZhY2cvL2xBa1gzdVR4?=
 =?utf-8?B?UWZ6aHJrbkFqOU51NTZTZFpsVEI2emxDL2duc2lTREV4UDFURGJLbSt3U1Y3?=
 =?utf-8?B?eWZpaXZuVEdtSWpraDN6bHpKMnIvdC9qZ1Y1cC9Eald4WDZnQUg5djM5ZHNN?=
 =?utf-8?B?QXNBSExGVzlJOS9pUGQrbWwzWlhZQ2xjSnJLWDRPYkVsQzRQUjBsRkNnbnpW?=
 =?utf-8?B?UWxia0d1aCtmRVVYdm9rRjlwaUFjb1dkaWx4WXhpVlJqZEhFS1JtRUZ1dmNC?=
 =?utf-8?B?U1RXVURtekowZytNL29yNW1SYjZtanlOVGcreURNZzdvWTlkNC9BbXowTUJT?=
 =?utf-8?B?d1JTeGZpZG5uSzlFY3Z3NmdRNHlyZ3dEWHVRQnd6bGdVUWZYOFRCWnA5VzFR?=
 =?utf-8?B?akMvQzlnWXF4VUxiTE5SSmllTGlNTnRLL01lSmkvNWI0R1JLUnA5VWEyNFY4?=
 =?utf-8?B?UVlBMU9sSHNWRXFhZ3FnRGtVOFlmYmUydWpKSVI3ekVWOEZUUUNjeHp1R1Ns?=
 =?utf-8?B?WU0vWW93a1AyRTVOc0w3NXAzMHI4ckZEWkdUbVlHSWdkNG1qcXRGMnNvQjE3?=
 =?utf-8?B?MytvWEczNzQwVWNkdXYvSEx2eE5Xd3o2MldnNEpDUlA1OEdrV3QwOU1JaFla?=
 =?utf-8?B?N1NUNE5mTGdPaGY3c29jbXBmNk9QRllad1JUNStPcjBZVmJxbmlhV1hyM2xh?=
 =?utf-8?B?S0YxalV6aEVCcEs4UGpHbWdheGRudnBsWmZ2R3BVYitTVjg3OURZQlg4eFpC?=
 =?utf-8?B?VEUwQlk1Q0U0UXdYUFpISmJVdDNBMlVaeCtqUk1pa2RXRjQ2Q09LUlluQUdo?=
 =?utf-8?B?UEs2VkJKajI3cDJBRXpoSFpCWis4UThRTmdWRFFOZWpwRGoyajJrWmg5OTd5?=
 =?utf-8?B?MDZFSTF0Q2dWdFk1Ny8ySTlvMldsYjFSWnlCaGtTZzNHVC9tL0YyTlBBdkJW?=
 =?utf-8?B?MEphL1ZtbXgxVlVrb1Arbmx1dmJiMllpdzVyYVl6cld1UkQ5S1J6YkdYMUFY?=
 =?utf-8?B?M0gxZk16REJJWmpGeHpidmViNENFZUlTUWZmM3YycVRST21tRXFDVWt0aHl4?=
 =?utf-8?Q?aC16RIwvN8f5mFAjfEU5F7BDxcqFVJGfNQed44eVB0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC1E4B55F3559D468742792025E0D003@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad26387-55e7-447d-474f-08dab2629e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 06:16:25.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MyTG49INoXLIwqAY27z0GIxdEdpHNfQW8JqIP/XmtOYf7T8GscUVZQzxXitOzgdlXJfi8xMCcKVJz3+Rst5YDJZVL2fLxc1MCSgK/J6DVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7664
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
