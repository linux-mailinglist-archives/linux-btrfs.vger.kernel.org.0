Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8567860F4C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 12:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiJ0KT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiJ0KTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 06:19:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC8A1AA
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666865988; x=1698401988;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=pOO8LlmuBPyxqcuR5WNTDDDbx18wgEjPlcMT3ptyInkqaIZwqSPJfKlD
   e/sZ0yporTCu1mEvyHPEOv46C6hOmA0zgmzp2N+cv6OkDkjy4aQ9meEkq
   Ua+Yn488XIIOGxARxkhlCGoU3kHbmemVHNxVqp4XcOppMpJzLlz44GoI6
   RLp4jdqM6PazKVmkZ/M6LryaWMWq+LUGbvz0KLfuDz4OY2v2MuHr0OC1I
   Cb/eugd+cch7yYM1yp1MY3mOw6SFLK16vAkz+wsYf1uw/HEEGhFgmC8lk
   uiUfrY1vCIvmRyDBFlKWne8aH3+tBN9nsLaU2poi0KHZa/l1M3kWIKcCO
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="214863339"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 18:19:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoNkLVgFiI4ksTjZS3CNlU59yAT7xv9f4AzX6MfIvdcU09waAVu+Wp3yY2aX915g1ey+U+GdhjMl8T3bJvuBzj1+s1BNA30FB2U8H7CmNhGoqhjKQEO9CJOOXeenfDrNmg/kMVHwabZ11u1oIN/r+nNjEEMj0RMWFEkHA/KY0Jyw+4cTRgsYXz1LD95DJrcPAi0qssAFIjXK9pO8hMDtljskUDbcqh1lZpoObdADA8FL6risMWrwnU2PrmEL3elx9yNT+HkZToDkgqD4kxaGPIAwT8CPTGVoZW6sMuR3gGKAWlcC5uaHhUNiVc1JxbpmY/gfn28i5XhNVrY6ibobpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZC2dsnofTFLAZqJF9GYQT4WUcEuGcAdETyB1NHmYSk5TbdZ9O8Asy2GP6zbWFupOWCcmD6lVHQD9/MHnHQbnQThlJ+9vMi+24i6lUFDJFf6Z4qEtD5SjKGYu1q418rQetvpbUlclGhCe5Ms/AZKJ9qOdGJen6Jg8YJiKmDrRBCdD9GSiOxRJ+eoUYHVBTMeV0QEf30JrlfOkRp0ZMCJLhZjhPlTi1P8z72UkmnxSzSJAhj2Casn5UgyAMojTMSP4YMxktBKOC8kYBR6KO6oBbaCOwuXT8RoE2FK2cr96EFf1hVgMstjD0mkuEpu2kQnGPq2gcIhuP+1r46tIwJuxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fSr9oECUKLp+Mj1lcdFerMaSnhDZlrGBzvvhL5SEmVSEv7nsLdtdLMSWxi8Z0RpkmhheYDTjlqirV93yyX4idnmwC/yAtDFyf4H5ZwQm+MnZVh7gI2dCbd2cQSVOPxKZPVhv6PkSHfJeL3quawhXPi8CK8PbTzwOmrQ8iGZ5/7w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7993.namprd04.prod.outlook.com (2603:10b6:208:344::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:19:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Thu, 27 Oct 2022
 10:19:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 22/26] btrfs: move verity prototypes into verity.h
Thread-Topic: [PATCH 22/26] btrfs: move verity prototypes into verity.h
Thread-Index: AQHY6W7nGS6at8CoH0yaiDEt4Cih664iCGgA
Date:   Thu, 27 Oct 2022 10:19:46 +0000
Message-ID: <843856b5-5024-be81-e873-fe595ce78f82@wdc.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
 <13e4b83f430478460fcee9eb6e4ab160346fb0d5.1666811039.git.josef@toxicpanda.com>
In-Reply-To: <13e4b83f430478460fcee9eb6e4ab160346fb0d5.1666811039.git.josef@toxicpanda.com>
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
x-ms-office365-filtering-correlation-id: ba6e8192-aec5-4947-1457-08dab804c5e0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56qDudbfgUNKhEo/tLy4nOw6vQ4kaMSGaUx9Ww5aYuVwFA1NcwTbDgHtFhNyymNIt1QPjc3o5YMJzpjNheGhBZaCdrb6zTL0S/tZ3H+0qNC1Q/rEwhWQUmHOPO692fZ5VEuZrmCi7bO71n1K24XdU4fRSyrNPCRDO/Dj2g90niLV0VFNMM3cP7AZdxmdNX/VWwWPiTHaeGeDLSGqwrShObSikX6iacVpmpknfkxos5PiZfc+YK5iU1P9pfpzX2UESgvDsCDtm6G1StcAnN/0cUH01jOLgGnhTlio0Ba+F8eoCwOL8PrleemVYpib0SveMExvEb99Ye+IRcZQeHLs8ikaLfPmFBgHwit+GdvynPYwgNgebtGvUmW421c0rE/HwWGr45ZMU7T2CX0TBfsHxnKV+qGJGqeulHwBs4mxrdeR8aQ6MKirM/pQc816NhJldglLeFHjV1xCk08eagZNVLl+9DuoG3v9V/xPhAtxPmLyAWOA0fZh6c3zMjAhsXL7lHPfZ3ob7SJV3tIsW7oaXx7kJhp7wS77Y1ZxTTJENxp7B+6Ffnd15IOZp9VlK28vtlUue5ZY7dAmS3Zdl/sxhR7/jJsy+nsHlryAx7VS0k49JBRVdZuqP/mOMzKNuGvj9gjOq4sXxizr7yY4YQ+bMXN5ADSIouEFAbxjaR7AubJHUAwM7cVMSrSQqtvWVvdGWVkj7c6mepyU0TVwmqSF4B87pF1sa7yHApGaXg5DhE6hJN4vDIb2rVxoKSJ1q1/Pewdahc48j7hJ9FVRPE+TpcvS5nigA1aM/gxjTtxgjk+Sc5fuMCkXk57QMDEGGKsxU0avJkysu8cpbY9bTB44Ug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199015)(2906002)(4270600006)(19618925003)(6512007)(26005)(186003)(71200400001)(36756003)(6486002)(2616005)(478600001)(82960400001)(6506007)(110136005)(41300700001)(38070700005)(86362001)(8936002)(316002)(31696002)(66476007)(66556008)(64756008)(91956017)(66946007)(8676002)(66446008)(558084003)(76116006)(31686004)(122000001)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWRJVXgrY0NqRGQxMkp4LzRUSDMwRmlNSzR5L0o5V1BFMzRQdVVVczZ1YkE3?=
 =?utf-8?B?R3MwTXN2L29MOUE5b080QVg5L3oyVGd4aFZjMmFuYnZzU2xvWm0yYnU1NElS?=
 =?utf-8?B?NmdKMmkrU1lrMzdZZm1JOVhqMkxoZ3E1Tmp0bDJMUE1ZNmcyR0gwUXRxbUhY?=
 =?utf-8?B?bHRGWnprL1Q5RGJ2b2tYaWVVcno5NFl1MGJTeGRJTDFCL1dCYnFTeWdLY1Fh?=
 =?utf-8?B?TitqZ2NXTW1IdnNsMWEydG5HY21xWXMvbXNwUkphc0pCMVR3Y25oa0NrQi9r?=
 =?utf-8?B?eW9jY1ZaZ29LYlZqV1IxRlVsSXhkM3AvWXg0eXVrOVRxdFNzMW0rN0xoSWtv?=
 =?utf-8?B?SWJOZG9kQTluZ2t5UU1odktwQWJESms3d01YUHZuL3ZPYjl0THlBd2h3TEow?=
 =?utf-8?B?aktXSTVYRlNmWHJOcmZnOVlYUTBRTG5ZT3hnSnQySFhONmFWcW9UOEtqYnZG?=
 =?utf-8?B?WkpaMHlYUFh1bGJwK3A5T25aUE9xQmpUZ1A3S2JySFJHbFloVlZMbHcxZk8v?=
 =?utf-8?B?VU1YU3NCSjZLMGdqYTFrVEo0OFFTWk53bmtEb2N6T3pKZENPV3lrQVgzMUVM?=
 =?utf-8?B?Ui8vVTU0U3VBclh6RmZ4SnZyZkFRT1grM3dpTjlzaFNkdEI1bzBpZHAvaEJm?=
 =?utf-8?B?MC9yaFZGSnhzWUFJM1p5bjFPeFBjTSt3RWtvK3dwcm1ic1hjZDcrVXNNb0sr?=
 =?utf-8?B?aFRKY2Z2SjFIVmJSREhBQTFBTDRoeHVLYTluS1ZrenJIY3BkRnpwb08zZ01D?=
 =?utf-8?B?UnBiRXRpTTliTHdjVDkzQVgzMUFPdTFjWm5LQ2JxWHg0TlNDNFpxTlMxOGp3?=
 =?utf-8?B?VjNvSlJMckVPK3hNbjFER3hDZU90VStVY3Z0WXhEVTJFRVdJWlBMYXpaN1Y4?=
 =?utf-8?B?dUhLWjZnNzBMWThnVU9OZ2owZUxhYUhHbnlFbEVvY2VXNDdwbVlrSnluNGRm?=
 =?utf-8?B?b2w0T1MycDlkZ2JxN0NhRzE4dUEvM3VlQnQrdW9mUXd1THNnWFVVZlFTWmpD?=
 =?utf-8?B?SGNSbjFUZVU3bk1DWnA1VlFsNEJJL1pUc0R6SG1USm9JUHNCOHFrczc0bE1Q?=
 =?utf-8?B?MlJTM3FuekN0MGN0RSsyWGY4WXA0M2xxL0htdnoxZFNwUDlDaVNBWWxuazBQ?=
 =?utf-8?B?QkhEd1ZvZzFSRk43NnlzNVN1dGhEczRLUUYvRndGSm9BRUQxUXdtL2EyeGQw?=
 =?utf-8?B?ZE9sSTZ0ZGRsMnlad2xiQ1VNS0RSZi9WdnZFQ2JuM2JKQ2JlcVQwcm5TY1JK?=
 =?utf-8?B?d2FhV1dYcHhxMGF5aUpQRzRONnpkTzR2Qld4K0FWK1pwbWlvdHJDSlVLRVRu?=
 =?utf-8?B?K2MxSnhqOUdMbjgwdGxGbkRSN2pSLzQya2wwN1A4Nm9sdkpiZ2pFcWYvTzln?=
 =?utf-8?B?cDZpWmVSblc3TTR6NTA3NDFiTytMVmJZbElhbFVIWm00K3hHeUFlYmVSWnls?=
 =?utf-8?B?dWxTQkNuOC9Hd2xvdUs1a0JLcUJQREtiKzQzdnFDSExCRVEzWVBEQTFWT2Nk?=
 =?utf-8?B?eVhpMTN0N3dIWlB4Y1ZuUTZSU2hJWHJ4TndWVmx4SGIrV0RhcXNuTXg1ZlNl?=
 =?utf-8?B?QWJlTXMwUWlzclFqV0NlZTcyWllWSEoyYUczWmlwT2pkNm1DT1JocThNRURm?=
 =?utf-8?B?TnNyLzVyTWp0UkpoRlI0eUtHd2ROaXRWckhjb2xJc1YrSXdOTjF1eGQ2SzlI?=
 =?utf-8?B?cFVFNnZvNXloWGVpV0ZXM2VMQ0h0eWEvY2l5c1pEcTFMY2tUNm04NkJFd3Ex?=
 =?utf-8?B?L0lFeXNoUCtqTzN2S0dCWExJNURXdHIvcWtsUmFzVldjQnhqT0xCdkVmM052?=
 =?utf-8?B?bFYzeVM2cFNObklrcmVOOVhBU2JMVHIwYUJiaVJUQ0FwdlJBakR3d1Q1ZVhP?=
 =?utf-8?B?d0pZdWhVVkdJdGQwTXQxSzNEL0Jvc1Z3QzZkZFpWeWh2ZDFCVVdvQzlsS1BN?=
 =?utf-8?B?Lzl4bU5lZmU1RzQ1cmFUQkNiQ0FEYUhBVXI3Mk5pd2hFbEZwUjNkUFdIR0VX?=
 =?utf-8?B?ODVBR0VFRHV2UGNObHA2OHowbHZGRmt6bzlVTGRmd1ExMmJ6aTA1YWJldk9V?=
 =?utf-8?B?MFhnS2VmZk1UV0wvb09qWDdNMlc5MVRqWnY4M0pFenhoaFhkRGRLbE5BVnZL?=
 =?utf-8?B?LzFtK0tkeTNnUVp6NFo2THBhbmtxaGd3RDEwM0tKcGk4TXk2cW5nSGRJdEJp?=
 =?utf-8?Q?IQBQoEvaegHa9ZZxZVfi0dc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E2470462F2D1D4C87CB557E2E72E3F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6e8192-aec5-4947-1457-08dab804c5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 10:19:46.4886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkXzKVMVX+EjF2KL1CpwpVTEsj38e9cJyuHeOfkVjWqRbR825MKfTO7zloIlB84zcUPxcQzA4b7xo2tQGiC6U+cmJAGpEizgtGUsngoCnyM=
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
