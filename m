Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D666B2500
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 14:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCINNS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 08:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCINNR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 08:13:17 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735B74C6FE
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 05:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678367596; x=1709903596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=fpYfy8FM2JspC3xHQtnqLmSjszIYvSpqF9v9LrVOs67dMqKXgPSQLnZL
   qe/vuwOWKaxibVzvmnCcMjH09ygu5zxYhVqxS8iFF6oYCqqj3sYRaexKR
   wYFc5jc3sgFbrF7BNLbNkkJQKnmXPWLkQ/KVpoAfTUzoZR7r2ukaFIm9X
   e49GvsVvQFBxOVF5IpiCybJfRYCUaOa+mon13MfrwG76RjEtxSrou7F5N
   IICQoifz/VUG9phJctSL6bwfWGdwmkFnW49g/D6sSXuVrN4M2Ob9OwHhD
   uO0GZMxdafIXFdIl0zfc9KpWeF8bwkvAGjeQ+QwQsVUgRdElpt7fe0ey0
   w==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="223517123"
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 21:13:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGxY5Z9+qG2TFhNnYdHNfSNGNNZXGO2Om197RFV06dHIZRMv/CwQNFKWH/u+pd18G3K1QGz6JO8L1sJ5YPGJjprMoi9+iWcVkk/jF25a86RolxPuMQAzNAxORj04obY69bQM8+Xv9zNuzsSXmjePPKbbFYXW7CQj51Uuj9iYSDfl+W5mXxvG3uEKSoUcCNGi4UR3w4b/+ldEPJ0XRglgPi+4QKR8VfkLlG0sjXrAI0+aTOhGhuW7XgxjCxLi+Y+eTu2U7Wnjt1sv6J6Q4WbbRBZesYdXs6FA5VyPjmEoU9wW5oaTsJEFFk5Bh/lZuCCaWZcqpekEGQMcMTgl32tTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Hte/CshYN7E5Lskn5cu42OCyMchDW2rb2Tzy+lIV3aHc5bLsMyYIPRb9NMwjr4I7P5WGp8q3imW90dIsN6wi2aAJ4D5NDDqto/n0XwsNdRJYQgFKnsFh70Zd11B4pgRXA4QI7Wzo/o+fi2VwieiMlZd4rH5PaaNI690ZPAQ4fW+7LfAhDJRR6dH1riEu3LYqVeYze0rsY0YqkAj8pfC4e5p3F6IZukcAtjKdccRY7Svp45Kg2RIVm+nuuQbLyxcr2jWIgRfuUPf9fR2OQQWVjc9zA0kF1VEDtxMAl+nD/tjSGFRJ9F+Ly7+eOt7oxflrerXnyV4R0KvJfliDXy4/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RjY0w/iFpi7YWidWLMKOKCP6k7Jw1DWVEonS9BDWX6oEhH3kQHsU7Itfm3tu46tmHazdFtHItwX1pAz1L0f4LbSq6FRfzGeHD/Q6rklkhbdLlWy3SzQq89IbWM8eEsRoist9aMjb/4ILckdkHcWGDnZWaYqfajvW/xKjru0gWmA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR0401MB3604.namprd04.prod.outlook.com (2603:10b6:910:90::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 13:13:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 13:13:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/20] btrfs: do not try to unlock the extent for
 non-subpage metadata reads
Thread-Topic: [PATCH 08/20] btrfs: do not try to unlock the extent for
 non-subpage metadata reads
Thread-Index: AQHZUmaUiC5bzh60mEOXaum4/kphda7ybP0A
Date:   Thu, 9 Mar 2023 13:13:11 +0000
Message-ID: <b874bb27-3ac4-d760-b4e2-297527201d38@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-9-hch@lst.de>
In-Reply-To: <20230309090526.332550-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR0401MB3604:EE_
x-ms-office365-filtering-correlation-id: 81c73d6b-1753-4162-6800-08db20a00897
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 15CJzJLohpuI+M3v/9njc9Y/MyS6nk2BQIyc1whO/HmJO23+y6kLk4C1yOKqQaHG1pgO8HA+XzCJio4uI1g5fcXNMFSDentGSmWqfFt2bjfKLIEg5vMvxs3miaGGokZ7BQeR9rkWt4XKaUi/+kpuLLmzTwCZrZSloBCvOLo0GE2E7ScK36JX3k1SnVyTupBikCArcvTpigDQDmCj30WyekbO1tASpGKgfrBAobDEKwY84kSrhDBwZKccy6+yLyCGFf4uJnzLlfTkkNdEDoTf4N0IBKECpt9KS64xF6OWPTkmQq0nDMi1iV5X5NKHniUKSYvLjgkpz44LStOtu0ZEPLBJ2v4G++vwaeu6DHKYgNPQ2366jtDjThzJVTK1BlWaAVnt4uD3Mz9Siaxp1fbbY7mMdZDSe3+2yIzeqwPlztxAnkXRZ8crWCcLJf3qXxuy51D5154A2XxXfoLWXnq9yptozhkkjk5sY2iawXwRJHYvSIze1Xn7fVO5EUurjMbmf9iaVXnf+j0UkwIJuEttQHRMobktnBeyTnnE2hdHDRXffcenWreCywLsTGv1UdMH4VM41pjnKbR6Ecd9yex+j6BOKJI1zVefi6M23SsGeFU+uKhhwWFHwiAU8CQ6fdFmpQwTOFQ7ICrGTLSpOz1L5SwVrtrudZ1GQQJKpzV+e1k1e98lTorcKMAkqxbhMUAtiZyMFJFqozQB46JELP+erDGIiFeJQzsl8YSXbndtarRa8PioCvjV1rDT4/sGhs/j6W5dRYrardK1t8XDchGhlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199018)(31686004)(19618925003)(5660300002)(8936002)(2906002)(41300700001)(66946007)(66476007)(76116006)(64756008)(66446008)(8676002)(4326008)(66556008)(91956017)(316002)(6486002)(110136005)(6512007)(478600001)(71200400001)(6506007)(558084003)(122000001)(38100700002)(86362001)(186003)(31696002)(4270600006)(82960400001)(26005)(2616005)(36756003)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWVSK3Z2dFBEMEZnNm0zaWtIc1g5N0J3S1lDaEx4cnBncSs3UVExNFBUa09v?=
 =?utf-8?B?V1Rqb3dyTHJwZmtSS21CSVl5V0QxdC93bnhZUGU0Y2s1cHppRWVFVDEwa1gx?=
 =?utf-8?B?Y3ZJNWJucjlRb0RHRlZiTzNPT2s5Rzdkb0F4U3NqSG9EMnNJcVpQV0dTbnBS?=
 =?utf-8?B?QUIyUTE3SlhDUEJpK2hjTHpHekhzcUFtck90b2VqYmpLQVIybkNlUlRuenQ3?=
 =?utf-8?B?Y2tKcm5BYXlWaVMrTmxsbVdsZXJ1S1lJUHJJRXZKditEV1ZrSFpTSG9qNDdZ?=
 =?utf-8?B?RGJyNUFiVFNadE1GWW9VOEluSFR2ejVBc1BvbENQRXdteFY4QkxCUy95L2FG?=
 =?utf-8?B?NnhmTlNSTjNkdWVYc3BVVXBZdnVMTVdmMEVWMWIyaUdHM0wrQ2NlVFB5NVNP?=
 =?utf-8?B?ckNDRjJsK1JkMDQ3Sm9VYUs0Z2hRdGdHWUxsbGxKK3Foc3YxaFVRTERwUER2?=
 =?utf-8?B?RC94ZDVNV2tpRC9iY0dWT1EzS096VWJXYUhVWitJUnVJd0hEbzVYd1J1cURk?=
 =?utf-8?B?QWpkWXVNRVJNbFhkY3lZSndZM3BLRVFxcVJtTWdtS3VvNEEvaSs5MmUzVnE2?=
 =?utf-8?B?V0I5VHE5aE5hUnliZWxLVGQzRFRSeWxOaVRpSExrY0EyNGxjTEZia0hrVFdo?=
 =?utf-8?B?aG5tanUvdjZGQzNYOEFoNkdoRVVBQlEyaXIwejNiUmRxOS9IeXI4WXIrMkxa?=
 =?utf-8?B?YkRvaE45ZHlneGFMZVp4MndrZW5SZEM2aVQxY2xnYTFPYndoODFEcFdXRmNS?=
 =?utf-8?B?enIySTJXT0l4cGw0NmJKUnhqTG9saGU5UUtqNS9CdGFXVElYQXp2Skt1Y3h4?=
 =?utf-8?B?a1JHcG5ZKzYweHQ4WFJtUDJVc2FsNzZXTWNRd2loMFBhR0ordWtLZ09yQzlV?=
 =?utf-8?B?b2laS1E0N243amh2c2ZZWFRHVXFiOW81SzMyUHJJODB4OUsxYzZWNi9HUW5m?=
 =?utf-8?B?K1p2aG5aU2FKdXhFS1BmZk90WmtnMWtIazRCQWdLODJ6WkhSaTVYN2d4cm0r?=
 =?utf-8?B?L295NU1IdHhNRXNrVzg1OEtScC9sRXAvQm11bmVGVjlwRTNsd3BTWXgvSWhm?=
 =?utf-8?B?MG5RblR5S1BPcXh5WVZmR3NzYXFIR3VaNThESE9RTXdxV3I0Qm03dHVjZi9Q?=
 =?utf-8?B?SUwzNzJ1YkVxWW0yRU1tTVNMa0hmZk8vbXpYS3dGd2V3SlBxSkRFQlVMMzRO?=
 =?utf-8?B?VExCbmdKeDZxTGx0SmpIbE8xNTF6K0xQeHBtOEF1T0lyQUdzUnB2Zit1ZjU4?=
 =?utf-8?B?ZEJZUm1BaEJsNnJ4ejl3cCszdE1FTS9IUUZqUDRabG92S0ZpU0NPK2dNR3Z2?=
 =?utf-8?B?UHJORVh1QnJ1ald2dGJWNTU4Ky9lWmwxQXBxb0pzaW1Xd00rV2VhSEUzM2d0?=
 =?utf-8?B?RVM1TkQ5OTByMDVlRHhHSTJ3WGJMODYyc2N1WXRCbHEzcHhFbk5HNTFKa1dj?=
 =?utf-8?B?REJXYnFVcHAxWGljL0pua3hwb1V3YWZLODFCK1VmQmlYcll2VGh4VDgwbUx4?=
 =?utf-8?B?Y2s1akVRK0hnblU2UWM5YldzSFpXZUFwaE1IY2lvQ1JMaWZ6L3pVbTYzT1c3?=
 =?utf-8?B?K3gzY1Yxb2tLODEyNHVybFNYWE9iYzMyeVVDSnZ1d2FQZkdVdXMxOVFWVzYz?=
 =?utf-8?B?NE91RVNjdzU4WjBzREhJRWRKL0NtZmhhaXNmZlU2TXVyS3lmNFVHWjRNeUdS?=
 =?utf-8?B?bkRYZzN4S25HSjRXTXhESE5qZE05cHpZV0tEYlRyMHpvRnBCV0F4STlEcTVH?=
 =?utf-8?B?dmh1cTc3STNIN2FkZXk4WlYwOGFnZDRNTmxXR3FrYTI1Q0VKZVYvRnNRUkg2?=
 =?utf-8?B?NlE4WGVNMks4S1BJOEx3eVhZMUdMSDF4SjlINHFhNnUxVFp6VzZRKy8yMUNz?=
 =?utf-8?B?WEo5QytxenBEY3dabCtJRHpqYkh2T1FzRnQzVjh4QVoyeFMyMEdRcGtJRjNh?=
 =?utf-8?B?YVliTTlMK1R2TjdtNFlXaTFFUVkxeHRNVUhyeXdESHFvb3Q1eUV0NFJHUmdW?=
 =?utf-8?B?d3ZoTTgya0wvWCtmRTBQcUlxVFgrcllSenFKa1FnQ0piZ2FMZVI5MUhGSGZ6?=
 =?utf-8?B?REFvcmYyNkxQL25oV3h5MndLekQ2UWJPN1lKaVArTVU3UCtnOXdpbm1Vemww?=
 =?utf-8?B?K0pGN1F1SHdZNy8yMiswQk5xdFFpTDJvYkpyeE1kTTdXWkNzTDQ1eGQ0QUdq?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F1433710F406A43BF0E2918CB29912D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KQSE2f+Ve9eH/DY8BkeX5v7xc/c5FjXgOPqwUpKYCCp161eMWgeayJx+R+ofq6k8LQdM4WG5lz6+mNTMLaenlamhLrdO7r0DCru1mLWyh7BfE5XlC2KVNhAY7pHBQvXahJNw3fhu5wEHZaQhiwL7/67Kcn44YkN2BtS8tFEteThkSevfDOcQQRBYA+XiRlFUfCpm6c0F0s9JvK/13Ekk5l8SUba5HpLZmVMdPHPBk7pSGAODvT28OV0CXXzf6nXPhDqLmKUIVoVwCV3I8ebz/W1r8mMybawRoVUJf6VCKujwMbk5cxrsGSIzSISwGutPmt9+qdJN9ZglgcxsgCicmb3TnB9pq2fFxX0DRIgUiVeCcK5owJMO3SK1c9Cj7ekyNEAwcNRac+ulbpVLgNM//4+L2lSy1W9GMB/84VlCLbK+K8JxDDFBiB2QfirA9zbCEEJ/yGr+WeufzplHOGk8+6jhvbm2gQfb0NPIqYvbDTUxwTJPSnyM+24T5hSRcYTSFi56acITZP/oQUISPVHWEoPPWJuS1C/GNTHysEoBUP/4ak++4RnUXmwo7qLrvwU/GTZkXrAfgjXIeSR2M6fN14ig0XXt+Jz1sPeeA3mJW4kPKOeReI+FcjfuEZGc8Z2HO82Wi8CZ17w2utNoya40+2UjHoCRI37hW2l/Y9CFN4DSFfiQr9KrofSRfC3k3cBdny7mJvPakBr/lkFjw6+p+oDTzaxWTy1D+MSDMOM/8cEGJxHXrw1mt92yatFlSvXy1Nbc5IcI3w4PO5Y6yt8Mpx30gULGI6C5giIqyfItC3BQooJH8oy9ZDaZgB+pqvxmArMYhG4dexg8Vvz9JOtOUPsRN4y/6l1CN0MLZOQCu3vhztZBXy9Mn4LZwrbd60mV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c73d6b-1753-4162-6800-08db20a00897
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 13:13:11.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lncmbBNYZH/r2xYmWNXzCs+8RCo6zOXDkj6uaNHpDZbgpq8yBHY/gCeRGbnyuh6Kj36dZAWSoIyvvQkxJiMlIIP24O21ww63P5pdnL9tS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3604
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
