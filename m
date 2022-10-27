Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0819F60F4BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiJ0KT0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiJ0KTY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:19:24 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534F8DED19
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666865964; x=1698401964;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=luXSMGPdhISJ+qFE1FK6yZog6+mxg+SptebhDz3ln7xz5ww9zS17Jkey
   KWIvQFxjWGuosCu5FgZpvclPZbnFFqYtFnaQDGdTlynHEGNI4MGjAFF9r
   4v0C7449ux8Z5Da4aRu9sya6v2vMZFsGjG9R9SOrcPAkqZu3K81iSdzb9
   QBZmAeQSKDj3vH+/KgpuRzi3tutIkkguujINjBWKmeGfVelT2QDi1QILl
   +/fLNn2sm7P88xdcWdXgb5v/UPgVbBm8btiSwH9iPkd4bYG4s7EJmfali
   DqV3sGDvxSgbFIy8Z8QoLWXkGZQ58Kuz7OfhsKVRHpQR6Eypfp2C0eB8y
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="215224458"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:19:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvLc6ncW0m2XXNmJ/V2X/zJ4DA2xoVYZ16rILmhxWv4w9diBOY4Z1Z2EGLh+MnJzS7GqAli0DqDu1vjJ+4lYswNeSunQbzEp8i0j+JKvuVLll+8OJObNXU8R09vQu+PFeDYWshMPuK1z26ORYmIZqrYydHZKcYN/XJrb2urCUC+GeUr1wYF7T/cvNZFsdiOKYidt8NiKAZrrdL+a1TFdP7gLzfaMYKeUS45IHlP6zGbIEpmIRyN2iR8cOHHwS7iU18V43G51PMV4AxWLCNE2pJDIB3AqlOILtebcZHwnlFbBw7XLOZpF/i1c6+/F4KYp0uDjCqEfm4RefpyMTgWB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=NkKODWdZgIt4etKdav+2NQ7+30UCykmof0B3Q0aU3ye15xcbC/j0DYta4A8pTWZC7eNc6iyhS96haxFbtk9qe0cs3HAjwYY0yl4dNX2ed42EDEAHl+HdanOuIhfNNL0FMRP8CyDRa9V9dRo9TvqAdtWMWF3ZXeBsldDwRgpVl0MU8GAch91vzX1KOLynD3YgXseItKqqMJgMhkNZl/AtOR1BVYIA1XUb8A2kgoFIgoV32I6W64Di2Ui9VYp0LqnC6hr1oYWFLZBTYmMp0riMDPrranD4GV0jvDhxAvaCYupeUBH6fYADvAKHfAG0lAQXEMVMzdTypQuNqjdc6TGCcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Arv9sS62HY9/XFvq+1j7pt9zUP0Os7zKdDVEF/iHl3u2SfEya73HYt0goALxOxIBy5phrIIZKk6cW0WSm282CJiSr2e8wl9+6dmyY+mr046nfwEBz0WUrFwh6TlTK0WvOXJUFTIeOcEL0NIzYMrFautV/6RYS1KsMO8xU3+4kdw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7993.namprd04.prod.outlook.com (2603:10b6:208:344::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:19:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:19:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 21/26] btrfs: move dev-replace prototypes into
 dev-replace.h
Thread-Topic: [PATCH 21/26] btrfs: move dev-replace prototypes into
 dev-replace.h
Thread-Index: AQHY6W7nEaLxdhZ7YkGaIbx8KyhJS64iCEqA
Date:   Thu, 27 Oct 2022 10:19:21 +0000
Message-ID: <8c94e71d-d850-8016-5556-d39eaaa94976@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <1229df1f96a18c6f6990bc12c671e59252396e5f.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <1229df1f96a18c6f6990bc12c671e59252396e5f.1666811039.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7993:EE_
x-ms-office365-filtering-correlation-id: 684fc1a0-84ec-429b-3264-08dab804b6fd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qk0GA2lSa51zFneeSFcmno6K28/HXNVPGgs/y7tWEkgp1v5Nlzqa2e0SVw9nSpXLmH0mECxOpbcOEiUMhlliahjAtcIG1xeMW+96RcCYUfqNE+8BzRf0ZIAQNwbtf4cF5Oa2BlvWbxiz05ZyXrJN6mOCQV5yGNpGNvg+ie/9QN2AgkHgsT/xf0R4Of8LwEO3sxZpHBHHGOsiVFkUKrdrkLHTt0cKBJHpUgRzrVECSuijwSUIz+Pak4BIVcloDuNJ7p5NItxvQ4H9Le7Rfkp5p8b1HFdMU9+M5/vmN4GIlihRqsLZhCX32jPlnZNn08FQ7Z33yt4D1pmHTlyz+kcIMqZcFGRrVYDpbHOKWWka8rVYm5Z21cITkngzZoFzb77ZevKyz3AWJExKYfjrO6bTtYmkoNrrr5XoF03TFSO5ZSrtY4/Vcn//aC295WlHeavAATOQWl4LIcKYeoPpbb1Vqq6HnlWqktj1yEucqKMeaPbsSLtMy/bjrQ5ng6onrpDg0R2d8Co8egdjgFTyIAJ5bvyc6U+oq9467v3EeGojcYm2DDVOZKVHbni8hXCj8yG3JH1OTtSbowR6Z4rY7jbFzu0TMCvKZAZ79+5rDQo1FpyKZ8OXG+tGd5Rr1lwAdjBJQYeQu5ZHsmTQbDCmTSrW++jmtG8B9OMFMFTm2eNKDVMlWVaNA4heNgl/SkkFKS/FOlZ88hrRxp5aaQWZG+qKfw8iPt+KH9TKIOTqWk5OOIHApX5A7lRcO568jw9bWXhOKIq3hbGVGd3jNeK5U3Dc7Lm1xIspMWcWA9P5FNwm0o5BC3/Ymr2IG63+iTXGXoBL0SKj+5TGzARQXslIJcmegQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(2906002)(4270600006)(19618925003)(6512007)(26005)(186003)(71200400001)(36756003)(6486002)(2616005)(478600001)(82960400001)(6506007)(110136005)(41300700001)(38070700005)(86362001)(8936002)(316002)(31696002)(66476007)(66556008)(64756008)(91956017)(66946007)(8676002)(66446008)(558084003)(76116006)(31686004)(122000001)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eC83V3FpdzlFOGlHWnMyM2hiT2J6aUtmY1Jrd0pNWDY1RzVUamdMbmRyUzRD?=
 =?utf-8?B?d0VCN3NEYStFZm5aNjlRcDFDSWhld0M3RlAxeFJsT0FEYWNQMFBRd2V4bWo1?=
 =?utf-8?B?ZzZ6MUNPT2tCb0E3My9lMWVUUjJySk52TDlhTUIxZ0N0T0VMVGhQai9oYWVW?=
 =?utf-8?B?d2gyMmVyVU9kNkNWNUJpc2wxSjk2ZWg5UXIxM3JFQ0RUY2JiTXVsZCtZclN3?=
 =?utf-8?B?SDErVnFrVkczNXpwbFB0aDRmelRPL0R4QSt0Zk0yalFhcURMbVA3MGVsQXZD?=
 =?utf-8?B?WU44RkpxSjhXMGlKazJKM3BmVjN3NnRUeG41VjVGSU9uMXZ4L0VhWFIwUVJW?=
 =?utf-8?B?b2lNOHV5N05ZU2dGOEJFeFZkRGhUUkhnQ1JjYVFnNkxTVTBsSVBmcFNnRFpv?=
 =?utf-8?B?TVRKdk1UaitQZCs0VXZ3WWlwU0tsMElReDk4SDh4cnZqYlhoNzhUMFpMaVB1?=
 =?utf-8?B?SUwvdHg5TzFmMmVZakVvL2gxUEMzbzFOUk8wQWpkS09hUzU2UTZtTlpjZVFt?=
 =?utf-8?B?S2NuUTUySVZDeGx2TndQaGZTLzhrV3cyaG1GZXEzZStRNU9YdGxZU05WeEoz?=
 =?utf-8?B?YjZCYnI5c2tuMGJqd3FLd1JYTHdLQ0dWNGM4YmVnaHpWdktqNERnbCs3SEdx?=
 =?utf-8?B?QVY4NzBoUlpPcnpxNEFWb29vRld5Mm94S2NBejZLRmNObWUwNHdkUjNFQjN6?=
 =?utf-8?B?SWo4OTl2TlUwZUUyV1V5eURuNXZTRytjVmNab1Nqb296N2d5YlljNkJhYm1j?=
 =?utf-8?B?YTlyN3FxRDBYSzAvdTlGdEdwdDRub29CODNuRVR5Z3E1aktYUGNYTUU0Y1dP?=
 =?utf-8?B?ODYyTEhVYmNCTXB6ajFEdVk5cTBYcjFtd0VWcXVYZW5RcVdySkJEajlaS3VE?=
 =?utf-8?B?eTFPK1pwSnlGTVJSNy8rdUNSU0FVZUNGWnZBeU5qK0RkTDN6UmJ0YVVkZ3Fr?=
 =?utf-8?B?VHpZSThFY1ZydHNnUGpySkI3TEs5QnFaaGhmb1pMUUJCQXpyNWFwazdrM0F1?=
 =?utf-8?B?OXZXVXEzd0FGdGQzWEw2RFJNQnFpUWlScGdJYVRNVVRHUDk0M1pOSitqUzU0?=
 =?utf-8?B?YVlZWU1kdzR4YWdpTEV4L1FQMzdzTXM3WkM0WkxKUUZsOGJPR1NyWHA1b3kr?=
 =?utf-8?B?UDBiejE5Z0dpL0JJYjF4T0piWVFnYjlLdTVNckNmcTFWODFIZUZxSmdGYmlD?=
 =?utf-8?B?R215aStZRkRnTCtnTnhaaE9WanBMdHlNYU5rVERWaFN0ODYrWUc2MHlMZUFx?=
 =?utf-8?B?L1Yrd3lUbWVuNGFhT3BKT3AzdzV3NTI3bU1sSGhjelIzbGROVDRiUlNBZnBr?=
 =?utf-8?B?SVI5TzFjWHNia1ZNczZ1WjQzVFUvUzNIbEYxNDZpQ2cydXZ3Zlc2am5pRnNm?=
 =?utf-8?B?R1pWSFA4dkQ5UnErMlBtaWJ4eEZodEtBcHlqT0oxblVlV3BMTUVUTGJtbmRY?=
 =?utf-8?B?eXk5WXVEWTJZWmdlVkVOS25pTlIxWWNuVDJTeG1DZXJuZUpkYzloZER6aWtU?=
 =?utf-8?B?N2RiQWpyWkkrSzNRdlJ2U0krNnB3QXYxNTJZOUFISUYzMHgxQ2FLTkN0c0lu?=
 =?utf-8?B?S25WWHhSKzVxTVVvK2pTVVBqNlpMVHBpYnJpOHhwbFNLQjhtWGd6VmxaRlJ4?=
 =?utf-8?B?Yi9LYUV1QzdKbzFyY0owbHVCV1hTWEFHQ01vdSszMnpIYUVHQ3Q0c0VyVm12?=
 =?utf-8?B?bENCY3VwSGJlU2Q3bURkMkltby9tMTIwNzlMWmkrcEg5OC9lRlJ3L2lFdm81?=
 =?utf-8?B?MlFKZ3g5M1V0eVFtQkp3blk0dkMxbm80SUwvc0xmSHFhUzRvUUM2QjVTV2VF?=
 =?utf-8?B?QVVsaFJjZFhMc3JLcHBCaCtVUXY2dktwWUxHYkFob1pGNFdHTHFGZWdpVnU2?=
 =?utf-8?B?Q2hTV3B6SHg3RERDZlh6cFBJMDAvc0NGT3RMYVBzbzBFUUUyOEFkaitzNllF?=
 =?utf-8?B?eDVvSXJ5cVkvSWQxd3NtemVtV1lESXErVmJQTmtJN1pLbysvNHFOb2VKRTNF?=
 =?utf-8?B?SncrOVZpbFU3UGFTUWNGMXRtemNWS0t6WXhjWTBCa0VrQVpaMk55UEY4aEZm?=
 =?utf-8?B?eHJzb2IxRjg5STUwdTBOSG1QUXpDc3BWQVdQRTg3S0x6R2EyNjkzTS9aMnFl?=
 =?utf-8?B?VElSUldEelNMZDl6T0NzUEp3SXdodm94V01hM01aZGwwMDN5TlRYWmM0TmVK?=
 =?utf-8?Q?aPR8wS8YM2tSAX0QvrYOeqw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <847ADF255FFACF40BBF292B5A1587CF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684fc1a0-84ec-429b-3264-08dab804b6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:19:21.5303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0S1vEvcohQ7cwb4UfDn9gM/ruSOhXXGXKraQHYDYvGUWeGh8X3XdqX/gFmiBDuD64nOjfH/o0qB+eAGiEBcUTqABASPSi+Fi3o8QdwQyJIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7993
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
