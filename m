Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280B578AE3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Aug 2023 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjH1K6c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Aug 2023 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjH1K6J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Aug 2023 06:58:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32147E1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Aug 2023 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693220286; x=1724756286;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mZP+RUdiUFOczliEhI3P14vF5+QcN/prXLjiC/zmxOn5FR8PScnt3tNs
   iR7Ifuj8QTt2QwDwd0gl6WM8xMn4t+mDXYDop96riABb4jfVtaiMINs1T
   zWErUT4fuesQxMKOdJi0iXSTeApWldG0BXJPXdiaBA4qo1Eb9Ttp9+qHC
   LEe0tusX/4aipqO857TbPX5ri69n/kFQNfWQGlLR/5+L72t9T3LS5atUF
   MZkMNyFtq396XcePWB4MQrvuz71W0M5JH651efT4iVfltbux+YV7dNrtf
   eaulG/Nxl189shMe2K9ZWYCsCrQ4TuLokTcpWILbVm7UK/k5U0YTmzN4Y
   g==;
X-IronPort-AV: E=Sophos;i="6.02,207,1688400000"; 
   d="scan'208";a="242247932"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 18:58:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzxBVIPB11FexrbMB+wHrcFxAXp6LqVBcU2dXmIc6YytOfjN0KgfRdQwB2JCxSyTMSYIhyrxC9SRkoKf5DshTxuzudj5pYmuU0qZKF9IwJYNcdxsR+7oQM2JMMifFdS+qbZDJb77/NhzmLgxt5F+RDzeveDcMxu0lGb6R5ImsmMXu3gdv/eJLb7twdV8nzXQPGVpdUHAm/Fz2ZUsxhc+sBlQk35z6BNDjiaIXmTdLND9lm+EXE6d0INRkuj7KExturStNRspeNSICd4KI4TXDRVpkyyI7YOBI5Rb7auDOX8stNFW8jMArBWMyXWvwGv0MA4hUhTwF4LLLk/CbPmU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=U2d6itmOHJmtaofbsGk062IUjF1yjFMyHD0sRKy+6+vfkmGW8YdLntChLKgKLC4nyMJvnsUcBnXVEihF0HfGCM0z2W9/Tpm/ao0r1IkH8En8U4YSKFkElV4RCuRLwT28DdPyZKEQRfP3Bt0G0gy7iS6X+RoCXGG0riGQvtuJLNYF2hS08I1A4RYH6AYPs4R1Q2tJo0yrn5Vt6SCu/ISv9DABWW3/4ELs0SX/DT9GJBdPoy/SGFovEdcnJrqPwWqHlnkzUqRFLWcr3BC6P/WZ/Oua4lq2vKQOVdzqtLSiYh9S2xvoKR2RJ3rcM/GzRQB2tTviJ4lXTFCfHirGldswaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EGR428kd+WPg5p6eukS92ZBuWh1eP4nCqDhB9jsEI9cgdZkZlnn9zZAe8yr63Fk2W7SKYBeImBxwojGIBIlSeLN3Uu7g3V8jdCF/NpaqJ1f3n6cH0CApSQLAaowsx3YGzk3wtsTCoZGze/TitsRmOV4sz3GQ6RetgZjFdpFDeZs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6649.namprd04.prod.outlook.com (2603:10b6:5:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.17; Mon, 28 Aug
 2023 10:58:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 10:58:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 02/11] btrfs: remove btrfs_crc32c wrapper
Thread-Topic: [PATCH 02/11] btrfs: remove btrfs_crc32c wrapper
Thread-Index: AQHZ1cj6I9xoMf9in0yzJT6dwryj4a//kXaA
Date:   Mon, 28 Aug 2023 10:58:03 +0000
Message-ID: <d1d30256-53ab-488e-8370-a3bbd718adf6@wdc.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
 <8a7ac9267cb726add7fb8bec90eb1d50ddbd0b4f.1692798556.git.josef@toxicpanda.com>
In-Reply-To: <8a7ac9267cb726add7fb8bec90eb1d50ddbd0b4f.1692798556.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6649:EE_
x-ms-office365-filtering-correlation-id: 954fe268-ee5f-45fb-59b0-08dba7b5a715
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHikRPNvSxp9gYnhtBdaMLUPvbhaTflL8XURY9jPIqFXSQhV3/VTNl+pqO9d38KYzCKJmO0x92w1gqFBQaahUF+JPWj8Em8TGqgpa40F3Nksr20uCU1qyudLqliCVt85Tnhe1dwbceNqBsJa7OgCMY88D6jfenL1SuQBCbyjC/HIb8pwzVhqO8pfYiaFLH2zco9CCSsXLuPnIBZPL/wasnmHsX171z9TJVqp47k6oD2HZmzrIilWZlWuYNJAobr1cB5Go8Y6WKHH349ld6BithxvHdOjAcmF+fZwuMt+0IPGIuYAvI0Xp1rQen54of/j0FD2S3dicj69SFEotFDHclpEVD1qq15J+/5cBODmIIdCbAUXwLImhTD0uYbWFDSlsD7/r8YDADF7R3u7tjy1RMrALFa4H9wmI3H0LNRNqsfVPaDdDmDnII0Z4JVU0MZWVdeEVg6MHRO9QN69J0SXRFBRXeZcMrnw7hZLrdFdIl6QTmuzo+G7WtZyGfThMb6ZvXjCkmYlcZOAGC+4b4pdVYYa+mqIA95HXVIPH4qD/TEZBZWiQtOCZiPSGQDj9RDGQ5CJDTlVuPaaz1iFVXW2i4XGIKqqzztTkvlJ/NlAc4ZlHu/w4rJdNFaFkpArN2DlRSW8ieqZ1VNBJDPu3nOeYSGe+l3hFOUWVovbzqIOjTt4ZmU8BmRc7F3ysGOGmPns
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(71200400001)(6506007)(6486002)(86362001)(19618925003)(31696002)(26005)(36756003)(2616005)(4270600006)(6512007)(558084003)(38070700005)(316002)(5660300002)(110136005)(76116006)(91956017)(66946007)(66556008)(38100700002)(64756008)(66446008)(66476007)(41300700001)(31686004)(2906002)(122000001)(82960400001)(478600001)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlBINHJwWllOa3Y1ZGErclJxT0R5dHhjZnJiYjNxcjI2Rm0veWk1RzVnZDNu?=
 =?utf-8?B?ZXdCbHErbDlvNytSRVBlaW9GMVVjcUdZTVVYN3NwNHNPMG9EbnBDM204VXVI?=
 =?utf-8?B?WTRlV3NpUTFXM3paamRodUtLOEpEUm9JZ2Q5RisvYmZqZUF0NmNtMGZONVM0?=
 =?utf-8?B?SXBTWm5Odm9YbCt3SWl0L1F6VU8wQ2xOeTdTODk2MXRIV2ViRHBIU3dROWt3?=
 =?utf-8?B?aGR1aVNtZGJnUUNaaVBUWDBBYWhidnk2ZmUycDlXMWJ0R2RmclFFRWhpVmhX?=
 =?utf-8?B?ekJBK2dBbldnOG50ell6dmdWVm9HRUpjOGp1eTdwdnRCcTFrY1I5VUZXT2Nq?=
 =?utf-8?B?V3lhR3RFZGlRWkE3bW85MXhTUW1IamJiQWpMZzFrbE1uREswcUhpTXIvZ1lR?=
 =?utf-8?B?dTVFYjM0U3ZnL3I0dTJXQWZCRC91amE0WmpSdXBUa0ovbnh0ZEZCenNFQjN3?=
 =?utf-8?B?UHBCcGZhUzM4WDdoR3F2VGtyNldIVmZYSUd1RjIwUzNJVktkT1h3Ryt3K1ZS?=
 =?utf-8?B?T3NBR09hbDREdGYrYktveHJtV3g3Ly9nRXhValQ4NTVIY3NDUSsyNjFXODVa?=
 =?utf-8?B?WUVNeHQzdjVHNmJRWENzVGUzK2pBSjR5dGxLMERwc3VKM0ZYL0puVjNKMnpN?=
 =?utf-8?B?TUVCTXl1eXV5czY5cDBVbms2QUZkOG5ENVRmYkc3Z0RIRmQ5TmF2UmFvWUhJ?=
 =?utf-8?B?eWt0ODRNTy96MlN6RlJsRkNrd0JNbFJYVm52eTY2cWtUR0JOUUh5TnY0bFVT?=
 =?utf-8?B?VjRYVFE1WXkrbTFFeEg5VmhUeGcxYlBMamZqNzFZelppb25TR3dNSSt0bHEv?=
 =?utf-8?B?RnFuM3I1UXRBVWNsWEljTC9renlTV3F3RldVNjR3SllRdHVBUHkrSnBOZG05?=
 =?utf-8?B?VVFMR3d2VVlrVEpkSStiU1kwUUpxc3NIdEpYQjFxbWdsbFNhWjlZVzgrMnlv?=
 =?utf-8?B?UzNRWnV3eE8xYzBqZFRBbEpZS2VzdlJlbXh0YkFsU0lBT0UxSk9WeTNyYSto?=
 =?utf-8?B?VHp2ZEtDc0h0eXA2V1hUeEFaOUtxTE1GWDJGVHdBRElmaTJURFFuUHZDRDFH?=
 =?utf-8?B?TjQ0VlBRSE5oa2JqQVVHK2tDMVNxbUNSUTUyTHYwZzYvZ21OK1I2NEpqVlFj?=
 =?utf-8?B?WXdlMGJHenEzdHhmL3E3OHI1Vk14UjMyeE4zdURqYXRQeUJvUVJWNG9uMkpZ?=
 =?utf-8?B?QjhYeGpCYmE3K2tPL2RmcUp0OVpwMEF0WFZ6WVhtc0V2SlNyZXprOWZwTEcz?=
 =?utf-8?B?L0VzY3hMWUo5RFZTV01sSXNocVJXS1lpWkxOTWF3NGlyeHViTDVuL0VNWVJB?=
 =?utf-8?B?NlYxZXcvOEF5U1I0dWlLNzJKdWxLQk9Mb1ZaUFlFYzZzbHk3dUNyVTJYbXRk?=
 =?utf-8?B?dXU5dlVlOG5IQlAwYUQwQjlJdnpqMlc2YWZncjhvNG4zZUVXOW5tSTlzVXVx?=
 =?utf-8?B?ZnljOUJpV2F1YlZrMWtHNWJjWjloUmVyNHZmY3FPTmJ6WTlHc1hUZlVMTXFQ?=
 =?utf-8?B?YWJQTHFxYkJObjloTGRrZmNweDRqMTFTMFNJY2tUbVlTdjVlR3Y0eDRnVTJh?=
 =?utf-8?B?OVZTN1V2dHNFZk5ZZmsyN3pIWitlYU0vcG5JZmxzNVVJSXBpdUhPMXRtVnNQ?=
 =?utf-8?B?c1poa1dMUlBOV0RpSzNGT3A4cXBaQ3FIN1FQQmZoTDhVTjBZbnVKS25RcGlD?=
 =?utf-8?B?UUpTM0N5L29hdWFiUlZvTXd0enA2eis3OE1WcnV5ZDV2Q0RpTzgvVTFDTUFp?=
 =?utf-8?B?RXo2RGpXRlJRVnd0YmhnbEg4VUF6bnZCT2hWQWJVcTFyazh0d21kMkZyK3JC?=
 =?utf-8?B?R2l0dUhmTXp1QmVIbFVPRE5LMDMzNUJTMWExQnpJWU9SYnJGeTc3QnJKbmZY?=
 =?utf-8?B?YjdFUFVGUVgrZmJucEt5VldjU0FUN3c4Ny9uYStOV01zMzlieFJ6WVdIQytP?=
 =?utf-8?B?bHN4S1JPNytyd1VHei8rUmROSGt1bThMQ2podmhSaG56Q2hMZmo4REpqdVdx?=
 =?utf-8?B?ODkxbVAwdmlmYk9kVkR6MGVJYlNacVo4SmZrQ2dDN1I1blRxV3lGRVpqbFVE?=
 =?utf-8?B?MkdaQXZkVjNPSEdjOEdsdTdqSk02dUdNNkhNNlRLdWN0Y0kyY0F3OFNLOFJt?=
 =?utf-8?B?cHd6bWRMS29HNnJISVI5bzFVLzhRRFUxcnYrNmtINTJ0VVNhV1drbFFoZmJk?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46547BFAD0BBAA4B988C8E38A5FC6E4D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FYoRmKGmzvL8gqHvEm3zbywhrbNYdUMJwFcYbH10npOgfRxcV3xCnlcpeLTIgGmte+r6QCcrtGJiCO4DoFquMYlFnKzHZ0aPlI7O7JBLmGO9W2Vl7CR1XzToL4wUK4wqM3P0/CA00Tc5GusHHvkU5xaejghNxndoUshDCoqHXl0gcpV/0T9bPA4Cr4H+6H5Li6A7NAlk4K0tydOjEG7hAcMgKwgkHU8ywReWZEeHu4P5LU60X8kpYsHbjN0uqXuQuFz4NeueTlg1zcY4KZJNIlZW74cw8dyollDIOCy9d7RSN4viuDynkBFYta/m2Q1FmYBpoUhsidHYqHlYqMpPppUVa5VWUXLOYLEFfXmRU6ocFYUvwD8vcp/U5qabZtAcZ/AqZcq1JnNMUedoEWaiAB1BnJUUF39skUlczNMW5EL6nrG8o33lZbuF2EFoyG69dEcG2n99y1b00BV2YWmYfFGJDn3TcFB3PjZZuniqRgp9jYv1eNxuqVA055PX+sJK2JVNmcRJ5g9Tauuw4rDCEy4XlmbVTHp8kEitraUFHd0kl62CWjdipIUxzLxz8SwQ1fHdvhLUQhAHytxFEmOzzVTj2QG0V9Ejw0gLr2Gn+FC8ZckdofFdm9GvZUbiA4iRjVGLq/3Diztld9XD0JdZNLkaf1tsW4QC4mkzLOriSolzgAG3J6NmxEVdbUQkwYoYsIvcR7X2TGKsZD9G+rgqDGuyz1lQdYkIFHC9BeAmToEaWuNiH2orpsE1MfG1uy3guvMI8R/ScFPSqDyIgizdlA5wPAVZLNEnjZ3cllJ4GlcvIVlAy+fHRgWq1PMe12gBrckwGAwjMeFwmAG0lvLBeA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954fe268-ee5f-45fb-59b0-08dba7b5a715
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 10:58:03.6898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jw3vNIWU5qmN6LzopQbsWqSTJGKeSFMMl2NQ1bVSOm6VOKpiEGNGeEudJEGqIqM4e7ZS/n/M5zzBrDuwIyRSttl6D3piLSNP1BoeP0yliPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6649
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
