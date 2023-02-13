Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54FA6944A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjBMLhc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 06:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBMLha (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 06:37:30 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1592118
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 03:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676288248; x=1707824248;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=C+RiSFgxnrw8zDgfEopw/ysP40bHu8tgpFES1VSBcLw=;
  b=YOZHM9hZE2IIy+ztnsmGqOTmZh4nFzmiYYRyikaofTPGLW6GD0TLpwXJ
   SJujFlY6UrY4EQS/xAH/AGWY2dtrHDjBH9pXwtC3gEV+KUl6b/n6EZWpz
   wr2p+KnXRrQIdWrWJzHIWCHKi7pCFChsBcUgbxOeXljuiv2o9J5RYghkG
   XEjSmXo7LRw1cib2aB2wVwcGVB3u8Ew2J+WxC9/KpkEL72fFPZeYtWepd
   gdMUvZ2wFHqWNww1Io3VDK1mGPxKOsPqrgDzVYVPK4fzT07IHxqiUxnlO
   kpekmuk0lOpMgyJKlhGJJx+6I2ypLlyFEiPGt2r+Abb2FnUs9EnNds1kG
   g==;
X-IronPort-AV: E=Sophos;i="5.97,293,1669046400"; 
   d="scan'208";a="335141232"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 19:37:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXTTrqed+8b4Norw1JVI979dQLKJAfc9g0qCtTRmG0f9hGtoWb0mamfsNOnNerw3prMSY8zYKYCFwpGI50AVovU19TzHNo50mQtyCvMDuZM/ZDROy5BFHb+y1CZXDBBWLx3fR+hgo05isXPV7kLNCLm0vEWW/8qXgUD5EUWDBApeQWZ/H9iN10ESyYIupcQtJ6dZBq+JH2yTCaos0dsN2kFi1vTovXORXpmbDpA4SVGkrpmKrFnJa6woSwbx9+sBxg7cHQlUXAADA8WzyaUrNkwyQAxzI88E0U7H/UMLyfZTG7KWGWZ7qbWc41gYe+4925knP+biFTNj9q27WSxQ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+RiSFgxnrw8zDgfEopw/ysP40bHu8tgpFES1VSBcLw=;
 b=CiqTfAL5cIp4TqGxk8CSzIqcggjKJZUB017ly9w3e1wKWJEhMahyEJaV/BsnnULGA6AnN3Ng44up2s57BIK7LbbIPZ6F6zsSvK6UEDWiuPG9C3l0hDJIgsMkFESHa46QIxH5K5QnbLdoqAaC/djZKnSmVnTnE2iHUq3rriuwa/6VDJk+Ko2dFrUfQeUcdaXqcgAZFXai9E0mxvNJ2yCJQLy1vt3PrrflV3S6MWsJCKXMmUe195JBvvGPxQ3F6IOwd9PwKt88EEpNBCs78guBsD0vqVlCalb1ShpswkvU6agcbmqdW+0BmpDkuXbg3MFAVYklSpEdgpgUUuR3drts+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+RiSFgxnrw8zDgfEopw/ysP40bHu8tgpFES1VSBcLw=;
 b=ElPwqpE+x2lP8z42IweaaXXUCPqu4pE5TXZguKbXBIFtCMrcHna7BFndFnUl9QkQDNeeyLb928LNGrBf+QrIz0FnsuK0fULuY0C5maV73mhJ+2tv0IMwtxBrVk/oO8Pb1JR476NuAtfczdtrLHw5aDkaDF2W9NeAYFpsoe9wKwM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6926.namprd04.prod.outlook.com (2603:10b6:208:1e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 11:37:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 11:37:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZO6w3+DMLZggJn0KZylohlYh4hq7MhYOAgAA09gCAAAZkAIAABtuA
Date:   Mon, 13 Feb 2023 11:37:21 +0000
Message-ID: <185452f9-b20e-6556-3a1d-0b8aea7cb182@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <96f86c817184925f3d1e625d735058373d90e757.1675853489.git.johannes.thumshirn@wdc.com>
 <54c0f200-2598-37e0-efe8-1cb6d65c9774@gmx.com>
 <30f068ad-d704-9316-992d-290630256712@wdc.com>
 <d107a6a1-4b9d-0e72-9779-1ce905b815aa@gmx.com>
In-Reply-To: <d107a6a1-4b9d-0e72-9779-1ce905b815aa@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6926:EE_
x-ms-office365-filtering-correlation-id: 5ceafddc-2faf-45b6-e386-08db0db6ab81
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ABabgdULYJLqiJ7AZsXfGCMvZDd67+8zXt3FGuWkhOFLizYG7VanQGI8i9vE8NVkgpzW/mW2pNGCV/sORZ7h8HGbY+3Y6r1L4O0xS+yGdqXI2hkDuwpLyi0r9DYeEdFcQlS16e40Jy5iS+W1AV5tNjB4zDK6pgtMBDefsODIFjH8lwa9SWGcQ6+9S1PzsF5nWLKw7+/FhFf0UuL3keT3zA/lzkWeQnh2gh8H71GgeWx9fbqdD7zGYZ2zOHXlMzsHGZmCsf9K4Cxj4Py7T8FeQZnHPdOArqZVeVptLtbhl3kvoRRRp8quaBGHfn04hb/HHtbCjn2yG2+FVxn9K5kYO+skMoSMzEepLowotd+8xHRAVcZvJdBylRk4G99lfsgRz2OuTl8WEM04BKjAAY4uyF6imL3q0RNrYZWAGUbWleT4lBzt4Qb1KCFPZlbikVc/5BxTlZsRVJ9xWZIdqCshJKzLQFTSwm32Tu+hysxDnSJnn66m21c9QmA35aYofhwA16GD0+2zxi+p/pL0foda8hlfuYLNEw5CwoYNv+LPevQKlBOCNNb2SGGch3ovU/fh0LW3cPWbsISjpFZCXgl/L4Ed+1bq1AuYTW3LyEXbe4x9hv49Z95RlDzPMuL7BojrOPS3Zg4wFvrlYRZQslJl4+lRFGjF+97hVRhFxufooWiFXeRwYgyHW+pHCYA+iwfwZ3pU35q/Q6zXlXIVzDcaf5APamcvIHSWPTbxGjCtz4uPO06WatgoXsMBk7rjnq8PDyDg9mDCn3EKry+/b4sF1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199018)(82960400001)(83380400001)(2616005)(36756003)(38100700002)(38070700005)(122000001)(8936002)(41300700001)(71200400001)(5660300002)(53546011)(6512007)(6506007)(2906002)(186003)(31696002)(6486002)(316002)(110136005)(31686004)(86362001)(66946007)(76116006)(66476007)(66446008)(64756008)(66556008)(91956017)(8676002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlBLejRsTzJvRUR1M2pmWDN4KzhDdjZKaFFncTlHeVc4ckZ5UWtMOUpNcnQz?=
 =?utf-8?B?ZysrekRKZitxam5OSzFqUnNZd0FPVlpLdHpESkJzZklFRjBXYWtSSWNScEJy?=
 =?utf-8?B?empROG1UQkdtTkxVdnJ3RE9wQ1lGZnZneFd0WExSUm1UVFUwMHU1L2FmRzJP?=
 =?utf-8?B?a2xFYzl0S254SlVmaHViU3pDazhKNDJSOTBjME1IVGFOQW9jNHJjd0RGYlIr?=
 =?utf-8?B?bi80SW56cXh3S0FqUG1Gc0N0eXNhemRXaUcvUzB0cFFmUmdBbklEOG0wN2F4?=
 =?utf-8?B?NCswZ1hlTzlhMjFwNVVaZ1I5WDNCSE9lRzNoRTUxd25zdGRVRDM4Z08yMi9x?=
 =?utf-8?B?ZGZ6cENwV25ETHhYSkhmNXdMRWtraDZSc0xncm52a0RZem53aXEyQmdCeFNI?=
 =?utf-8?B?NUJIeS9QTGlXdnBTTDRYNGI1L0dVVE9KZFRRWFg3QUFmOG5PUFZHWElUbFRs?=
 =?utf-8?B?elhPQzY0K1Y0YUZVMDhQYTJ3bkFlV1ljeEpWeDRaN1RocnZPMjBROXFReGQv?=
 =?utf-8?B?bncrWHJxRlFPZkxvN1E0cTNid1V0cXl4ZGxJaWRnd3NKTkVvZEFpd2pGTFhU?=
 =?utf-8?B?YzRqMGlLb2ovOUNlaFRYUWREK2F1T0NPbjdRRlFvRTU3SEtyVmtSQVVPSkQx?=
 =?utf-8?B?b3NKRXNzVmNoRSt2bTNLOVZROUg3c0Urd3k3bXVzWms4cElra2V6OVFkUFEx?=
 =?utf-8?B?U1dieXVIaU5pZWdndDV1T2ZMQ0JTWlFPOWE4WUFlY3hsYW9iZjVhdGtuOCtO?=
 =?utf-8?B?aW04UG82cGVSbTNXME4xemg4My9VZW5EL0pEelYrd20zTWt4VlF1MW5oK05Q?=
 =?utf-8?B?N1J3WXdaL0lGbXN2NDBtNTlIY0ZNajhRcWdXK1VuMnc5L2lickE2UlBJa1hn?=
 =?utf-8?B?UXIyc2RIV2VkcUJCNmJCM3ZodDFuckVOZVYyK1pkSUhjOEljSk1YN3o5cUQw?=
 =?utf-8?B?SFYvcThsY3N1cEI1L1NxWTM4Y1BWVHV1VEVFZUh2enZLRDNoeFNDaWVRVTJX?=
 =?utf-8?B?cmFnM3ltd0tnRzNaNmNyV3UrRDg3TnNkaFpRbWdVVmdzazl3NHBPYXBhcDdl?=
 =?utf-8?B?MWNPYjk1T05hTk5NNmRRNWRtdy9KVkxlRkl1YUZyaVhqNVVOeDA5Y0hYOTNv?=
 =?utf-8?B?dzF1ZVFFNnhvRGQzM0YybWJlbUQzOWhCNFRyZHk0VFVsclU4TDI5Vm9RZzBl?=
 =?utf-8?B?TDJGd09CZkh5cm9pYmtvaWtzOFprMXZoSVd2QytXKzhSSmhQUXhYRkY0Z21h?=
 =?utf-8?B?S3AxSjE2MzhUdE1td3g4VDVQbENtU3ZLNW9DMEp6NEVHcDhGdytmaGVXTHdt?=
 =?utf-8?B?WkJmbEhnVHdTTDE3Wm9raXpoYkVTdmNJb0FweTBHcDB0L1JTaEF3Z1h3bUow?=
 =?utf-8?B?Vzg2ZU1GY2pmQnlNcEJ6MnVBYTlPS0Q3ei80TU5wWndQMGRqS2ZINGZzalZX?=
 =?utf-8?B?TkZJMmJoeEVvcFNneW1zVGFSNnhrN3diRFhMdlEvS2l1VmZ1VkRuVXRVc2hJ?=
 =?utf-8?B?UXdQdUxCSS9NNThEZ2w2QjVZd1VDdUVsYWtyMUlOSndqaWpFazY1cU9zQzMr?=
 =?utf-8?B?Yi9zd0ltT0JZUVRsQ01VVjN3SXVHWkN0bUR3Um9EdGlhN09oWHN3bzRzV25t?=
 =?utf-8?B?d3A2b1pMZzZZeTVKTnNkaWh3K2l6clJTSnJPZ0svaEs1SjQ0OTNEdHZya2Yr?=
 =?utf-8?B?R2o5V0ovME9hcHdQaW1QZDFQNG5CaHZJUWYvajNGN2I1cy9YUHBqWVdQSTd5?=
 =?utf-8?B?WnlkY3lhdnZRZS82RmcwcDB2T3dmKzZvWG5qTmEyUkdXc2NxTjUzd2QvT0NN?=
 =?utf-8?B?blVCeTI0d2JBT0pMQVBIMFE0UHl3MDMybHZSVXp1Q3lpbVExWEpRc0hpSkxV?=
 =?utf-8?B?Z0N0RzJEeTJTcXl0NU9pVENOSDlONGkrU2lWNFJQc3pmdjFuZFJ5STZIczVS?=
 =?utf-8?B?c0JzNGFCVFZGdjRmbERMQ1dEU0NYY2xZbXVLalMybnhvZTIvMU9qTldvZ2Nq?=
 =?utf-8?B?YThOVnZlUXVkSnU4aGljOFppc3B3TEh4RGNCNDBwaFYzbU9vMmgwR1FHVlFN?=
 =?utf-8?B?aVF3M0RuVUpzWWkva0Y3MkE0YTBvS2ViZ3FjQytnNjlBZCtpYU5NdExvQlZM?=
 =?utf-8?B?ZEVNUWw2cWx2bngxZ1VSaHQ5SGExUkJtbXRZRklEMStGdHg4N25ZVXJpZmI1?=
 =?utf-8?B?UlRYY3VBZUsvbzdyQ3BCYzZidjk1U3c4OG1qWm5iM3NaOTMySE45b25wWUl6?=
 =?utf-8?Q?4SOfYJUtkhH4J+CINXHtwOJiDGWE15mhVL3joHqhCY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4382BE6DF786844F9D23C19D4DE62D60@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jNoNdSjBvaMTN9XRocOBDk8NK+lHIlOXqWlQnaafxdh5YvrWeUo+ugjwN+MZwIZS3cFMkTUIiVMQTkvAsW30qCK/u/qy9YC8GQzdjMbbhG8AehyRtLGwvf8MrRuc0SZ+Pcwam9Wq+GG/s5ih7D6ocY23QGFbXfhuJFn+MZukGHtUmQFczRGlUOnEXn7itWB3XU0Nmu6ma4KOwIhdymco3Zm97gWloaRaQ9d6dksRnQ92txim/4tfdfvIkVSdFrGDi1S7Ak2dQ5nNRDyl8YL+DBv8SSajQUiufeP4F+1Fz1e0LmomqHABEn1SyNSbeVCnpa+EGyYdPVuDWu2maEbDKXNR6EXyIWKTJ5pjm6ucUKc9i95m7WVrPCpMKNzykKMZ26+UcLoRmc2i2EhdUlSig+dCgZR9d6P0l9E8maCT/Lrwo0HGFgUUTJOqxJSmG3VysgFKwxhLqS3qJ2ApfVzPY9TrV04lHqK8mTys4CJ/xHZbYwkZzQhQut4dMrTwlSB3pmU05WJuRnyUaQ+aJnZ+XAL/I5NbwTa9ImRaOUwkLZO+V22NC3IrK8gFGRZI9bVCICz36fOfAzg2AZw6Vnv4q4Xr5XLs1TtwE4e//kMf2AT73muF9pFTBcsdWJOMINELwogYIi2N9y4ON8XrsVrmSMAbU2gX7VL2rn/a6OPAoc5CBSGTov1EWBEFrOBS+5SIP8IGUhUI/P2LQe9EY2cvh8zzUaxbdMdpdqLJfDvULhWXKGAk3mE3DGdX61ARDegMNf1K5KcmQ5EINXLN6csN8vzmQQv6XwUnJr3ubC7T21tUp0+mzpwBK8B3DgNx0zB3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ceafddc-2faf-45b6-e386-08db0db6ab81
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 11:37:21.5369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUWIOhG5qpodRCEArh1wJO5WK7rk7NoTAf+T4HSMTIcRpDQVcN6FOWYb5gL7rcSRjhW4zBK2eCWTPvLlwtphW8iX9xC9kof4ReAGAgQZb5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6926
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDIuMjMgMTI6MTIsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIzLzIv
MTMgMTg6NDksIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+IE9uIDEzLjAyLjIzIDA4OjQw
LCBRdSBXZW5ydW8gd3JvdGU6DQo+Pj4gU28gdGhlIGluLW1lbW9yeSBzdHJpcGUgdHJlZSBlbnRy
eSBpbnNlcnNpb24gaXMgZGVsYXRlZC4NCj4+Pg0KPj4+IENvdWxkIHRoZSBmb2xsb3dpbmcgcmFj
ZSBoYXBwZW4/DQo+Pj4NCj4+PiAgICAgICAgICAgICAgICBUMSAgICAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgIFQyDQo+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiB3cml0ZV9wYWdlcygpICAgICAg
ICAgICAgICAgICAgICB8DQo+Pj4gYnRyZnNfb3JpZ193cml0ZV9lbmRfaW8oKSAgICAgICAgfA0K
Pj4+IHwtIElOSVRfV09SSygpOyAgICAgICAgICAgICAgICAgIHwNCj4+PiBgLSBxdWV1ZV93b3Jr
KCk7ICAgICAgICAgICAgICAgICB8DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IGJ0cmZzX2ludmFsaWRhdGVfZm9saW8oKQ0KPj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCBgLSB0aGUgcGFnZXMgYXJlIG5vIGxvbmdlciBjYWNoZWQNCj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgYnRyZnNfZG9fcmVhZHBhZ2UoKQ0KPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCB8LSBkbyB3aGF0ZXZlciB0aGUgcnN0IGxvb2t1cA0K
Pj4+IHdvcmtxdWV1ZSAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4+PiBgLSBidHJmc19yYWlk
X3N0cmlwZV91cGRhdGUoKSAgICB8DQo+Pj4gICAgICBgLSBidHJmc19hZGRfb3JkZXJlZF9zdHJp
cGUoKSB8DQo+Pj4NCj4+PiBJbiBhYm92ZSBjYXNlLCBUMiByZWFkIHdpbGwgZmFpbCBhcyBpdCBj
YW4gbm90IGdyYWIgdGhlIFJTVCBtYXBwaW5nLg0KPj4+DQo+Pj4gSSByZWFsbHkgYmVsaWV2ZSB0
aGUgaW4tbWVtb3J5IHJzdCB1cGRhdGUgc2hvdWxkIG5vdCBiZSBkZWxheWVkIGludG8gYQ0KPj4+
IHdvcmtxdWV1ZSwgYnV0IGRvbmUgaW5zaWRlIHRoZSB3cml0ZSBlbmRpbyBmdW5jdGlvbi4NCj4+
DQo+PiBJIGhhdmVuJ3QgeWV0IHRob3VnaHQgYWJvdXQgdGhhdCByYWNlLCBidXQgZG9pbmcgbWVt
b3J5IGFsbG9jYXRpb25zIGZyb20NCj4+IGluc2lkZSBhbiBlbmRpbyBmdW5jdGlvbiBkb2Vzbid0
IHNvdW5kIGFwcGVhbGluZyB0byBtZS4NCj4gDQo+IEFub3RoZXIgc29sdXRpb24gaXMgYWx3YXlz
IHRyeSB0byBwcmUtYWxsb2NhdGUgYSBtZW1vcnkgZm9yIHRoZSANCj4gaW4tbWVtb3J5IHN0cnVj
dHVyZS4NCj4gDQo+Pg0KPj4gQW4gb2J2aW91cyBzb2x1dGlvbiB0byB0aGlzIHdvdWxkIG9mIGNh
dXNlIGJlIHRvIGJ1bXAgdGhlIHJlZmNvdW50IG9uIHRoZQ0KPj4gYnRyZnNfaW9fY29udGV4dCAo
d2hpY2ggSSBoYXZlIGZvcmdvdHRlbiBoZXJlIHRoYW5rcyBmb3IgY2F0Y2hpbmcgaXQpLg0KPiAN
Cj4gSSdtIG5vdCBzdXJlIGlmIHRoZSBiaW9jIHJlZmNvdW50IGlzIGludm9sdmVkLg0KPiANCj4g
QXMgbG9uZyBhcyB0aGUgd3JpdGViYWNrIGZsYWcgaXMgZ29uZSwgdGhlIHJhY2UgY2FuIGhhcHBl
biBhdCBhbnkgdGltZS4NCj4gDQo+IEZvciBub24tUlNUIHdlIHByZXZlbnQgdGhpcyBieSB0aGUg
Zm9sbG93aW5nIGNoZWNrOg0KPiANCj4gLSBidHJmc19sb2NrX2FuZF9mbHVzaF9vcmRlcmVkX3Jh
bmdlKCkgYXQgcmVhZCB0aW1lDQo+ICAgIEVuc3VyZSB3ZSB3YWl0IGFueSBvcmRlcmVkIGV4dGVu
dCB0byBmaW5pc2ggYmVmb3JlIHJlYWQuDQo+IA0KPiBCdXQgdGhlIGRlbGF5ZWQgcnN0IHRyZWUg
dXBkYXRlIGlzIG5vdCBlbnN1cmVkIHRvIGhhcHBlbiBiZWZvcmUgDQo+IGJ0cmZzX2ZpbmlzaF9v
cmRlcmVkX2lvKCksIHRodXMgdGhlIHJhY2UgY2FuIGhhcHBlbi4NCj4gDQo+IFNvIG15IGlkZWEg
aXMgdG8gcHV0IHRoZSBSU1QgdHJlZSB1cGRhdGUgdG8gYnRyZnNfZmluaXNoX29yZGVyZWRfaW8o
KS4NCj4gQWx0aG91Z2ggdGhpcyBhbHNvIG1lYW5zIHdlIG5lZWQgc29tZSBhcmd1bWVudCBwYXNz
aW5nIGZvciBvcmRlcmVkIGV4dGVudHMuDQoNCkFoIE9LIGdvdGNoYS4gSSB0aGluayB0aGlzIHJh
Y2UgY2FuIGhhcHBlbi4gTGV0IG1lIHRoaW5rIGFib3V0IGl0Lg0KDQo=
