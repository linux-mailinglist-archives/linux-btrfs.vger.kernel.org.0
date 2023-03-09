Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08226B24F9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 14:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjCINI4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 08:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCINIu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 08:08:50 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA8E51F8C
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 05:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678367327; x=1709903327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Dc0zYxM0pCr6MjyHDUpVs4q58z1eDy0bOmB0VkWDovR6LgvTVbxivUVC
   gWmBtX1Qq476hYidu90pE0PXREo1BubSc6pq17bJMckc/97CIni3pQHxH
   gegoCWmyzU8CnZN2o3i5SogkwgsBlWOhcPRd/I6/qz/ODeydAoYbVH84X
   s4jzx4/BhbxCl0N+S1CshonCd1zHyHiWm/Bjvx4CerMrxRWEzdVgnMXHl
   Iuv1P/DU4Dh42bHd0Ez9Y8jBuzKvIN2BAakJyojE5DnpuBNInJzBEBktb
   STNKpz10ia/anlxeSTtzRIuPQrPR9wc7zu0mVGfB8R9z/24iXVoXmpfe+
   A==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="230177800"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 21:08:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo9Px7vKga934rRBkpG7RYkzWL7TRdq/Nnf94LniOCMi0AcjE/ooyfRJclvjC6CWLPc6wWmZoa81zskm+9MP/FqM4iCEZaYSjQ1V5imge2Q+xqT1DWsWM3F954H9cNc+izHoIc5zrxHzu3N3nQzMeWb55ukU7LAeAfkVkQHweTU/ruz4C+5jqttGBuAOiJaOlKQEOrzkcpTIQ2xru3TBf6SC9/qOZDOrZkpMU142XuErzPk4qLRgo7gMNeo2qIJPRxeqy36KZUXNo/KSDDs74iIStqRvC5TxpK6TX/AdyRCsDKU5h7nuN4YhvXBU9/McbSTPYO5FLODZwlJAn6ZfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=LOHeBj3mO3kuJasGfMndAYmmMDwPRvRMHrbT2N/jPZjJO7eiPhdb5RgIi4ylW9sqQ1EbsNIcaNsgGlnnkCMCcValt4ApoXKtEW8O3ZgXJImfxjXkzxwjBIL+OS5er4swI0Y0FRtxvkwHx2nPAaCUSh0Ts4cFdKqvCHABHe42pujhwhE2+SizV/CzW/tpgPGEo32qrUehSGqt4L9Ac+uqJYkvZxbudmruZa50oAlQpMDGrpOl6nNGO9Xpb0BbDhhDwGBPNVMSIYut2ME6BxMIrjoTSPDOZ9ycQsi2kux+Ck9fJVeP24w/G7lrSnf58u9hX4ujGUUB15XQqTivlLzqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=T6yzsCutsD4AXkvlTwsJGS9esPzdb3em/6DiofDwNSU8LaLOkodxHUURtat103Tw6a7hBTwtAFyQWsJiljATMSuJJf+Lku73hGUnBXg4mNyexufFiGHInL/XXl7fry6t9HUCAwnPxFIpv+eBWksLvDwwe+Zryg8/2l4WYM4lFi0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0388.namprd04.prod.outlook.com (2603:10b6:404:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 13:08:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 13:08:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/20] btrfs: simplify the read_extent_buffer end_io
 handler
Thread-Topic: [PATCH 07/20] btrfs: simplify the read_extent_buffer end_io
 handler
Thread-Index: AQHZUmaVxgsuf1B80UWB5NUSVdkYAq7ya7yA
Date:   Thu, 9 Mar 2023 13:08:41 +0000
Message-ID: <52123b04-dcb9-477f-5b97-1d027d21a716@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-8-hch@lst.de>
In-Reply-To: <20230309090526.332550-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0388:EE_
x-ms-office365-filtering-correlation-id: 38acf497-a567-4110-d097-08db209f67e5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNYAa1CEbrTSmjBMO9CRXKf9jHyjq4tzdCaY8N/LSJGE8nd0itY1lBCIFZPNckWvMjKf7GfM03Bh0gkVBpxGcoHEjBgUcAtXSgVDS0RwoToYbfnNb4NyKm3EFvkoKIURK1xIO8OjF6BbPMaXkt2fN9TOxQCVxCgx2YyyflR9xTe/kn4gZbMkg29C+bOgaVSHUPRViA7mG7nE2lkph+3SX41btf68Xa8VC2osGX6fcR5lBIZJ1bDs8NlKBI4SKv2U5EyvUavEBkBPQmqK3gxilvn8GDdF8+iRHQvoKcleCrSOM5ByvoBb3m0tES259p8YOIAflEMziTJm/+Gi0ofTFHyCw6IC1k1libnh8AzZ8VxZQSM6rYpvFd8bu/5faE0mG6Cqhy7GnOHhDa+s3Idi7GpjwAZGkw3947nGj6u0KlDrdt2RwcjKaa3BNbF3gQ7xddyavnmivkHp5Q8xfJubsKNFpPyJWk4p6WyImbXY3eYpF/1cQpLNNU7LTW9zhRtJRADv9mQCSpRgQoT9ibxXaJ1pvUVqdGkK3J79A4QnS5+qPTQ5YVmlIIZjQRxAajEo5S2mtLhpJvniHKvzOKzUVxdkViPxQa60oT0r+Q+WuZlNOsinrjl5MPAwluYDNebHTgj6jaXDnG+pGEV1DGjiBKt/xHgSDWMRJAe+Kq1ogcXmeKZ/f/lCikdV5aVlCIyjJH7wLBMdZ/UW1XzVWqfLKyCLWrAa539+d0mrhMzrsxRWt50SukYD0DPgrK68uxKBuN/7yrwTshhevciazvLA6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(19618925003)(38070700005)(31686004)(2906002)(5660300002)(26005)(8936002)(36756003)(41300700001)(31696002)(110136005)(64756008)(66446008)(66476007)(558084003)(66556008)(66946007)(76116006)(4326008)(8676002)(316002)(91956017)(86362001)(71200400001)(478600001)(6486002)(38100700002)(122000001)(82960400001)(6512007)(6506007)(186003)(4270600006)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXV1RDI1TlIxT3FmdHhlaE9INkx4dmI1dVVZc1BqK1NlRmpOUEROdmw4NVk2?=
 =?utf-8?B?MkpOOHhiaTBnbjcwRzhNS1ZEZ29BM0NlK08xR25LSnVDdkxqL2hiZ3JldlBu?=
 =?utf-8?B?bG1lQVVXSWRlWUxLdXFWRXc2VG45TGhycXlIdkhZaDlHZGNkWXVRKzFzVmtx?=
 =?utf-8?B?UGdGcld3bk5uWmpqMmM5R2dyeXhzcU1CQ0dHWTdzTVNDR1A0MVF4YUkyQnQ3?=
 =?utf-8?B?aGp3UzVDYXBMa0xXclZBUnlNalAvUmFFYUZ2bFZjT3Z2dW1FY1ZubHJjdzdK?=
 =?utf-8?B?NSs1Q0xSeDJ6QnNsUjJsZHBnd0VFY2sxNXhCcWpEYTd4S0l0TDBMOHQrUmd2?=
 =?utf-8?B?d2JoejNSM3Y0a0MwVEMreGN5M21qZndPZzlxNXRObjRINWlnT1BpNkI4azFL?=
 =?utf-8?B?NDRmSGo3elRBeTN6elFlKzNTcFR3YWNNbEt3ZzJPK1h4V1NSSXhQTkJjc3B5?=
 =?utf-8?B?RVRBNjVRSm5vVkRiVGVCZnR5eWdmTHgvcWFCdi9WSTYwUFlLakV6QnVDUi9r?=
 =?utf-8?B?bjJsSStrU1RLc3p0VUVQbytRTmNMVlZpRERJTThGU1phRExPODJXbC9ZRFpt?=
 =?utf-8?B?cWdTQWtqMlhScFh2bG9JSjYranpPd1pVdnF3ZWNYdzBrQTY2NDI0MFg0WE9m?=
 =?utf-8?B?LysvK0ZaTWdNV0ZQUzBmZHNlQ2pwVTdhTGx1NHdVbHNJeXNnclpvSlEzUXJD?=
 =?utf-8?B?bE5GbGM4OHA4Vll3Z0NSeUp4SEVnK3lZOG1tZStKT0ZCR2U1MitoV2ZaYWlh?=
 =?utf-8?B?Sk0xSXRoTS9MN0NuVXFqSndXV3dhdDZOczFkSjVpZHB5djN5aE92L2N6WkNT?=
 =?utf-8?B?elNoWHlWZUd4ZUYwMzAyQmdOQWQraFFybVd6cEl5WEtvUVphZHNxVENta0I1?=
 =?utf-8?B?WnhkYkl6dFlLV1c0cEoxMlVvRkdFa3lOSVA4eTIwN21LODhxKzh0VThDekdK?=
 =?utf-8?B?UDQzRkZmZEZJbXFXUmpHSmovTTZVbjIrcUpOSVFGMUhlL1dGY0wvOFB3cW1N?=
 =?utf-8?B?R0lzTHNJS2YrZm1GTDBwRGV1Rk8vbGRURVBqWnJUbWkrc0tFckZJeS9tcnVL?=
 =?utf-8?B?UGFaVS9xeWxXL05aa28rcDBUK1RRcEljTUxtaTcwVDBzZmNMTTFpd3ZVT2Vk?=
 =?utf-8?B?UHZwbjBydjVLdUJMdjVzYk5ub2FnMUcxdnRLVEtQT2dXS1dLdWluSk5yWGFH?=
 =?utf-8?B?M0wvK0NBTmw5Y3JEZnY2cGhra0d2cmNEdzdoYlFraFpQMUpPM2VqSDRORTFv?=
 =?utf-8?B?eW4zTTlXSUthRERKME52c2xJZDhsWHI1dHNGaTUyeHliall5NTdRVVk1Zy9p?=
 =?utf-8?B?dUNJS05nbVh2REF4T3JMQ29FMFJ2SlE5VFlLZHlxd212VmhncTRaczJHZEFE?=
 =?utf-8?B?Y1gvdXBENFR4WWpIL0l4L3Fjd3BWdy9XVDRsQis3ZW1wWjFCRkJrMENVM20z?=
 =?utf-8?B?ZmM5TW5uMEx0dmVCM0ozalcwYkd6MVQ3Z3poOVc4amhIRzBydlZHWlUyMjNr?=
 =?utf-8?B?RXdBRVFuVzNxWFlOT1dZTVBhbVRLSTNEcjd5a0lZMXNZZEtDYmN4VlBONUdC?=
 =?utf-8?B?Mi9qdU5rbGVybXJnWU9PemZXV2lTQVRLMHhVTTFxZi9SMHJ0VmJMbTltZmFV?=
 =?utf-8?B?eXZpYzJuNE0xU2VuVTdyVDZQLzZaOVZzTHlhRmlmK0NtOExIQ0Zxc2dhQlNj?=
 =?utf-8?B?MWowSXJkNG1qUHl6ZHBlbjdpTm1EZ1JFaFA4NjVQN1dXOTdpZmE5RjFFbHZo?=
 =?utf-8?B?YVpPdTdYVGtXT3RMVGhkc0VYeThPSXFIaWs5ZkE2YU1jRGVHOHcwbFBhVUJP?=
 =?utf-8?B?c0hCOWxSYjBDNDFNN1JWVHhrVnhnUFNkVkw3QW9oR0UvZ3oreU1wOHNEUm5C?=
 =?utf-8?B?NlVxRW9QNzFGcElJVngrbU4wWEtqS1N5dzZpMyswT3gwQjdxQmdqVkJaTEtS?=
 =?utf-8?B?cWxVMGhLMEhmeDV2NzAvYjFIbnVFQkhJSC84bkJ4QTBaK0ZYZXR6cEtxSzB1?=
 =?utf-8?B?YnRJK21ZSS81Ym03bEI1Q2ppTkNidE9yQW9ETTF6S2RITDMxVDVmcGY2ZzhV?=
 =?utf-8?B?VWZ5VDNDN0NUeFRUdG5aQllCUjVsZnhGZEFlQWtIZlFCRks1UnZHdWxBclo5?=
 =?utf-8?B?cEEveVJKWmZFOEhneXhMdms2dCtaVkRpRng1TTg3VW1VZDcrMTgrT1EwUHdh?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A38E61A1E4AD2469783CA6B74F8DFEF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2UYVBGvK0MvXHk+OGu7pCXmvU52KyRtKOGnJF2QJLrrMyiyo7NaqpRcqcK0mRklCdPU+1+vNoFic1XVnqTLzWoCTBYlUT5YNNnqaFvf9sCV5iTpgurUDueTjdVP2iFxtkxQT+kDmaZaXtlZ4jPXva5FMuKeDhoDao22fGQXvxaaUqZSl1Og2w5cuXGvJaFsHrBnsJhEa7auQ4+Jb2GzAC9KA+Yv3o7bNTYbXYNUCzPy3scqBOYl1XmI/URqHT5TIM8n4oio9jqBKLleNYOCmN6HpphamlEl5qayGjleIQ0AganAZiAj8uCEynvUcR4toDSO6XpdYroJAcgve6gg1rbjxZyk/l6tBNC9vaKxiLi1ZB7SKS3uB/usWTmejL42mjZvd4hIlEy8qZAtybkYyvdihurzzkqlGRFIWfMkEBjUhuQbCJnNqgz/rjJFVDmGQeiieHCiDu6M+KctpfP238d/0EQzs/WQicQWgth30n7OHAOsJYiQK6/AagjhmfDxK2Ke9vMPeKNxS0n7vBWJtYD+g7ZIoz/qdPrmha55VCd1eqhZSa8RHYEJ+kq9bnxhc0KbhPoDf7LpWPYBu48OCQl51UEkfytKI6giWWHwX5RhgQPcPKSOZkijMlOtAWDiLbtKLVh905FpKuFF9YkklYlDFJFProY7NZuPkS9xqlHgX/ukBcEXLlynipRHRLXOxnY7pix6i9g3PJFc3vkaMRbDvqsk+PeNKO6Ae+sGSiMYxS1h9EdjiJmfwxF/kyvrZAbzkbsB5cxGFm+RoHwZcSYRV0g8nQp4UBHxZZ+3iqv2Ffb6L1NMzMQOQ8cgz0yW4n5Vhn2Cx+SaklLE/ZYYRC/c+48ae95LLX9tPvJGftpnGwfleY0vtNl8xW5CCc1sO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38acf497-a567-4110-d097-08db209f67e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 13:08:41.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbHwjfSu/HwGi0KzmRl8E3OjTOugx3ehKhsLPdaQPdj+JoQr4+FPdMMa2mfYQS0g3D4SGtFduLtgv1bjnAvbU5Ngqxfwz42BhoL/eUdybdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0388
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
