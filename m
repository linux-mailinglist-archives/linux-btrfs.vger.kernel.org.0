Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF147A00D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjINJwA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 05:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjINJv7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 05:51:59 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220383;
        Thu, 14 Sep 2023 02:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694685114; x=1726221114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DsFSEromx01FnA8DTUdRsNrPIl08srYXrubK7MkizSM=;
  b=l5PMXBO2URDHsTFmAdmbb59Cymu/Hs/oDr9y7NXNtc5wUaJRzp29u96t
   Jua//2+1/FBXgylEN3UY9xs3A8uZkaaW7Yqwzk950m7gjvELOR1cUIgBr
   JxPjU34qDQEFb5RV8Cd4xliRCl5rlBLkG3Oe7Q8U0tdl0wKiYpm/Q3kcq
   kcnjqWal4I7GudBrN2+q00i+GR/bFLMiI7eaTb1zb8My2DYskGtsizL/c
   s6AUccl2RcetJXoKbmlHTUb4peGZtfcMDgAmsgZuvmf7GF4e62mGebnzw
   VuPe3vl3+7SPOx6MfovOPqwyDg3A9+xx+1lCp4l8pHyKHu4ODb6T/TVtf
   A==;
X-CSE-ConnectionGUID: w/Z1gYOSSp+g0REAreZuYQ==
X-CSE-MsgGUID: d7ananHCQqGF7xS+Wxl6TA==
X-IronPort-AV: E=Sophos;i="6.02,145,1688400000"; 
   d="scan'208";a="242164671"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2023 17:51:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYFQituXr5waKPCiWv2WIxlScQ1yVyIkPTktUFhTjzTZ2cOvvC0Nyi2skCylz7r1tNKpwXvfQFdz+sToz282K15FFHBkF4G3YnGKMmYlxqMJMHK2XUaWm0ZaGyMVE+XJQf/nNjWgCsfaoaV+umjjZp/wy7J/KOUM8m8KngPyj6UvjnpKDrakcDFmBoRJmWgKdlhiYJoHVeht4+zq7667Yc5BylEABjn868yLzBb/YTWoWIl9D+eIeX66qIW34qEqEozbEsnfHQP7+hNMNiTfcZ4stI0CpX31RUIbd2t1Tvz9F+cBiM1r+xozyqZcN4C9hhFd469750Vz+ZOUtPhpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsFSEromx01FnA8DTUdRsNrPIl08srYXrubK7MkizSM=;
 b=i0/ELbN/eP5dkuyaNPdvnnfiF4Y4iEiy0K21FrzdMZgdvZHQL0dCBvDnpj47cr+4tjXNC2xM5pO1I1jwx7iNUnlChEBLWX6Zh04tN1c8RTHgiLCTzz28ttwrE8nZSDyERXiY+koK5PeWTrxThjY3tZfhmRNKyW1/CEAGDrHXtAgNysE3PlFp0ButMogmuN9hJNgdUQYy/yw2fsObrsMCxV9IS/ziH0WBzWQk9bIE5SOR2jR5ng/uG+AIwMBXQVVw1bQHtbKZJ3IOSbE0S6QhBmfN6VhwSFFt/83xnw3qTb69PXgSkzr9cT+h1oX0OfbOFaQnvjvjgK08/GuBDgb94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsFSEromx01FnA8DTUdRsNrPIl08srYXrubK7MkizSM=;
 b=pY1Kjfee3osOl4sGcq1Y5CZ9xuf93PYXsX24Nw4lWoa0jgHHRSokVD1og2LZT+wEL1Au5FEK4mrS1veOiOnWHYdKrBfLAb5BTWsgQx5ztaoen7sZ6qWx0xHmGjHyLI2/IQtHAV9nFxCnGOEkQsCTI0+8XQ1P/UUcplv52SmXwkk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6824.namprd04.prod.outlook.com (2603:10b6:610:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.7; Thu, 14 Sep
 2023 09:51:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 09:51:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 03/11] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v8 03/11] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZ5K7alMSnA6X5wEKXERceny6RlrAaEXKAgAAHW4A=
Date:   Thu, 14 Sep 2023 09:51:51 +0000
Message-ID: <2ad7c49b-89ff-4f10-b671-6b2ba4ccbef7@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-3-647676fa852c@wdc.com>
 <a5d3a051-0b3e-4fc5-9df5-e70c94adb95e@gmx.com>
In-Reply-To: <a5d3a051-0b3e-4fc5-9df5-e70c94adb95e@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6824:EE_
x-ms-office365-filtering-correlation-id: 8209ffc4-05f1-48fc-5542-08dbb50838b4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bw8on1yh4QMPZWp+7y94O3q2ZCw/jZRHg1YBWM3EMCitxbn3ZaleQS/H9X701I5iL4hJZhib+wpWiaiEVrBTEP6CbAa0AYnYq8mJGlnwube5sgdaX9sryCjLX1A7biNibHrxXWg3Vbf5EmQhWzXz5rMJVdtkHDMCuovBfnyaEY5HQLXbZQsolXrqItMnQLb+ep/SJSIq5Apn38v4XKp5qMbuLjMImCftv52Ng0OjrKEcZRjrF2exXTdT6ejR6IJpF6eYBotVG/OJK9P94kADc83zp3F6UNZDiLzklY64p6TiwvVERnG8o9PDXSZaNEnJ4TMfBljV2+N0XLjG3ByofOcVTdBumjuo1TzfKyubDHcS2VA0PMcTdU/Kyulv90VFjvUp9+CYgwNwIaXK4vRGLW5m69QmvmojAGs7ZDJ5dWfFBHV5fzmuR8i49jt9pGGVDvU1dnVY08QfwUmgpSYwmc6j4tLETvLtl4IJEIy3LirtUdov71MWCUZVEaEX5Uch3NlA5dyPXpK3QHPhFevsTqcAq2/OKDjIr0KhNLgUzu/g8N36KF42tz2ytHbX5P/6s0x1LNwyx4jS5o3fISJ2HTARchiSdXGsVXAsDwV9wSSBVwfaSDqoGiHhOtBJciJE7XF8gfX0ej+N5wk7FyB065H3mbHP6muJWvLhEjSrTNpXic1cwBUqEptRPDkMr1LY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(1800799009)(186009)(451199024)(31696002)(86362001)(5660300002)(8936002)(8676002)(4326008)(2906002)(36756003)(71200400001)(53546011)(6506007)(6486002)(6512007)(82960400001)(2616005)(26005)(38100700002)(38070700005)(478600001)(122000001)(83380400001)(31686004)(76116006)(110136005)(91956017)(66946007)(66556008)(41300700001)(54906003)(66446008)(64756008)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGlMeUN0N25mQngzKzJJbjRrbUlYMU1IZnJNaUxuOUFRSWora0Vac1p4SHlK?=
 =?utf-8?B?T2FRU0pWbTZ0WjN4MTJXM280M0ZkNTBhaW05M2hLVE45SVBKeEpZQ0x5STJk?=
 =?utf-8?B?OHdUR0xhdllrcWRjTFdrYUVvWjBoQldmRjZ1UTJXT0xnL1hSenNvMmlWWEJU?=
 =?utf-8?B?S2FRcDZyTGljNHlUS2MzY05Ea3NNdy9xRUpnellodThJUmk1YW9jYUJBdVVY?=
 =?utf-8?B?MlhleERRSW1qV2k3MTAxd29NTE1BWU5ib09pTDFRYnRVMDgvVjRORnEzbmIr?=
 =?utf-8?B?T05lbjVZN1IvNmxtTnNHNHVvUE55NDFSV3A2VTE0Q3IzZFJtN1RtbTZDdElQ?=
 =?utf-8?B?OTJzTi9xSG0zTVFwbVlMYmNGUitnS2RQVXNWV0p0ejBBdkVyQ1lsRURiOXBx?=
 =?utf-8?B?aGNSK0JnV1BlWWJWSkh2cnpCa3NRejd3VWxsVnNoN1JaQ2UxL0tGS3FLVnZ4?=
 =?utf-8?B?dmUwM05lMExaNTNXUTR1MExiZU5LZGNVY09EOTJ1OFFtbjNVRUNDaDY4WjFR?=
 =?utf-8?B?UnpDaEZNbjcrbWFwN0FJeHQ5UThYaktXK1ZNZWJDTUF3SXN2WGQrUkhVWEMx?=
 =?utf-8?B?emJ5dVEzUlJ6YnA3azh5QTZ3ZDdLdDd4R3NYb2tkcGF3bkZZNU5ZT3hxdmxw?=
 =?utf-8?B?K3dKTDlpVm9DV0EvNnp5QTBjSm1oQ2pCWTltSkNJUnVONWJpOHBmMnhGSzJQ?=
 =?utf-8?B?RGRoekRxM1RtNHNRR0ViejVkVWZ1eE1Jbk1XWkZVR3lYbE04SitlTDJLWnNL?=
 =?utf-8?B?QUlFeHFKYWVIbisxY1dNZUcwWnRydlNtdUZIYnpVQUtKazg2aFdBTEhHTFlO?=
 =?utf-8?B?NmJKRWZKZHFLaVJKMnNVZXIzRUNKekhwYUczK01TNTB5QS9lTDlSMG5NZXk2?=
 =?utf-8?B?a054UEhEU3VyY0tHUTBwOTRsMDFlZElGdTljUW5saVhhVkVzbzFxZWhvSVFI?=
 =?utf-8?B?WWNJejcwYjcvRjlNK2t1Y1dmWXdBUGlaSk5JdUxra3JGT0liak82SVpScXhC?=
 =?utf-8?B?Nkl4Q1NVWGxXMDYveEZva1AvanQweFErdnJ3ME9HTE43enl3VmNpRzk1cld2?=
 =?utf-8?B?UEYrT0JiVEhjaHVjL0NtS1ROcmZveWozMkdHLzlWMkI5NFZRODBFbWw3V01v?=
 =?utf-8?B?VFpmYmpoRmFLYk5sTCs2RHVGLzFFQmpCOUw0aWlzWTJGN0ZkeW1lekdFYjhh?=
 =?utf-8?B?dW5YNHQxa0w5dk9xRmZjWkhoNk4wcEtJdXg0bFNGLzJzTG52ZmpVUkJoOHh1?=
 =?utf-8?B?TExMWDVDc2syMHRLTlk0TTJRYWMzU25XSzV5T2llbW9vcks2MkFMUDB4SUFE?=
 =?utf-8?B?eHk3d3hpU0pZSzB2MEt0S0QwNVh4L05TSm9MTkVLSEFlQUtTSU9qSllKQU03?=
 =?utf-8?B?MWR2YzYxVXorelBaQTA2Uk11eDNFOFcxcnJCYnBOZVhGVFhBZXNVQWxjWSs3?=
 =?utf-8?B?V0NnWnNWVnhBQmVCUU9OcjlNM2hjNzZEUHRIQkU0WExsdVYwaS9Ia2JjY1Fk?=
 =?utf-8?B?NHBJT1ZCb29uMXczMlFFS3ptbmRTWlJLUU5DR243OFdrUmpkb1RScEplcXAv?=
 =?utf-8?B?ZE9mc1pML0YyYTh1MHhWOG1xRDNtTGJFdm9KN0wza1V4d0UrNGdsRUFzQkRE?=
 =?utf-8?B?c3E2MHo3Y3JNa2ZRMGtLUWFjNVZvTWpiaXMycUZPYzN3NkZYZ3I5aHh0QS8r?=
 =?utf-8?B?WFVjTkU4djgrdmduYjE1TjkxRW9WamxLQ0JHUTl0Z2piU2laK1hNeUUyZ3Nq?=
 =?utf-8?B?dEhGbzNTUUxOb2t3V04rRXVTVlQvRTI2eDVuL0hkaDZWMGR6bTRyb09zeWJI?=
 =?utf-8?B?UitFSUFyeEhqL0NHc3pJalEvMUJ3MTJqNkNNZUF5RDZtTUIrZURUNDdmNEJP?=
 =?utf-8?B?UE1JeWJySnZNZVl0RDllSUs0LzRRSUJHRUUzd1FKcjF4V1dTVUVzbUVzMW9C?=
 =?utf-8?B?TGJsSllrZXRmM2dpd3paa0daVE9UV052RWlTek1ib0ZJY2hSYTBBeXlWKzN0?=
 =?utf-8?B?c20vTWdiRGl0NkpXdzJjRWlLUng3T0cxUEhkRU1yK1VGUnpWK1FDTDN3WUFy?=
 =?utf-8?B?TVB1cVRSQ2l2cFZzRlZ4dW14dHdVTXlrKzhvZWkyZ1laalRid2c0N3pBc2lU?=
 =?utf-8?B?b2NyUnFrbHFZa1JvV21WS2lGazZydUxKb0QxbGkxOU5yMzhGc3RnNEx1eTAx?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56515CD36E2CB84CA02DFBF862859D78@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OS9CUEwwQy9NSFR5d3RNTEJTRXVzT1lKVGdxc1lCUGNPVmJKZDNNRlAvUWV6?=
 =?utf-8?B?emwyRkc2YTlYV2pjRVJOWXhST2IzZ1JJSHhIci9heTgzVE02bkl0TlhCN21H?=
 =?utf-8?B?SUU1U2Z2OHVVTGZLRVloRTJnQ0s5eWlwc1RqaWlzd3B1bHRVbWRtaW1GRG1U?=
 =?utf-8?B?WVZXOGhKSTRpSzdNTWs4UDh1QmpsendrUEhOWmhNdXY1d3pPcnlmVHZqaWtZ?=
 =?utf-8?B?aFVCQTRjVmVIOUhtT1daZ0RGYmYyZmpERFJCcEVJQW92OEYxSVlLN2hrV2lO?=
 =?utf-8?B?Rk5vTU1NS0JYZEFyNW1XbXhsQmQyTWNVSjhuSnZXWlJVaE56N1BINFdBTWNH?=
 =?utf-8?B?U3lkMnFHWkVKaFBHK3BqMkY3ZzV3NVNaS1BtS1VDT1Fublg5UjdiMjYveGpY?=
 =?utf-8?B?Q0h2bTVRK3V5STB5d21KQ0ppTDVaSC9rUUpLa1gzdFoxVStaUTlOUG9KenQx?=
 =?utf-8?B?VjJhN0J2c3I0STVzYVBLcGt4cEVaaUw5UkNrNC9qM3dSRkNjemlkYTY1eVdM?=
 =?utf-8?B?WENFU25UcDZsTnprNUFTdUx4Vkpma0YrSDJIQjdiaDFheWZjZndVZjVUZktG?=
 =?utf-8?B?L0N6dmlwS3cybkViQjVNUFdaaXJhTGlhYUt6N1VnU0hxTlJJSmMwbkpXdTJk?=
 =?utf-8?B?SGNNTzFkcnRjamJmaHB0LzNXdXc0WEc3MWJEY0Y4OE9JYVdtQnZKUVM2bkQ1?=
 =?utf-8?B?UHR5L2VVczZWVEEvak56RHR4eS8zTWJKUFRHQ3JsWncxS2NhbnVoMzBodllt?=
 =?utf-8?B?RFpDTDc5enVHWjF1OW9qOGJhT3B3M045MHU1TkluaVdrREFqUXJwT1lnZDhK?=
 =?utf-8?B?SHdKdm9YcENiQ0xNQzluU004MUlhT2hsSUxQNWwzeFZLalV4TUh1Z1hESGZQ?=
 =?utf-8?B?SjRvYXpHWFVhRHhrMEJ2U1NvRWRuQ1kvc3pOdGFSQWJzQjBUcTFRbDFmN2lF?=
 =?utf-8?B?bUVnQTZlUzBJRzBUYXdvczZlMkJtRlV0ZkowVUVQVUlOUkpOM3U1QTZ1czVh?=
 =?utf-8?B?L2oxOVN0eEs5SmJJL0E0c0pqNzQzOU92djBNMFpsZnBJdzNXdlIwWDFvMVp4?=
 =?utf-8?B?N21RdkhrcndOTlZhNTRBa2ZoSjVKcUR1ZFdRbDJnVE9BYkFqanJsQ3g1U2M5?=
 =?utf-8?B?OERPKzMrMmQ5cTZUTVFtSkM4eUhiaXk0T0MwbVAzQm5VKzlMWWRJY2RsU0F1?=
 =?utf-8?B?NGNlanBzNitHTThONm5kK0M0bk9aUS9tV1FEMjhaQjE2V2Y3b1VXV0RpZVRr?=
 =?utf-8?Q?rXlsv45k0ILK8p6?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8209ffc4-05f1-48fc-5542-08dbb50838b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 09:51:51.8486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTIKPp+0hAjUBuiB1zXRtg10n86HWdmgR/+M2vNz6eVU+b0GJBcwnUojUrDZd/CTB64g1iLXsskLNY20jv98fKXBu6kBvRPV/aliX0qNf9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6824
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDkuMjMgMTE6MjUsIFF1IFdlbnJ1byB3cm90ZToNCj4+ICtzdGF0aWMgaW50IGJ0cmZz
X2luc2VydF9vbmVfcmFpZF9leHRlbnQoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMs
DQo+PiArCQkJCSBpbnQgbnVtX3N0cmlwZXMsDQo+PiArCQkJCSBzdHJ1Y3QgYnRyZnNfaW9fY29u
dGV4dCAqYmlvYykNCj4+ICt7DQo+PiArCXN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0g
dHJhbnMtPmZzX2luZm87DQo+PiArCXN0cnVjdCBidHJmc19rZXkgc3RyaXBlX2tleTsNCj4+ICsJ
c3RydWN0IGJ0cmZzX3Jvb3QgKnN0cmlwZV9yb290ID0gYnRyZnNfc3RyaXBlX3RyZWVfcm9vdChm
c19pbmZvKTsNCj4+ICsJdTggZW5jb2RpbmcgPSBidHJmc19iZ190eXBlX3RvX3JhaWRfZW5jb2Rp
bmcoYmlvYy0+bWFwX3R5cGUpOw0KPj4gKwlzdHJ1Y3QgYnRyZnNfc3RyaXBlX2V4dGVudCAqc3Ry
aXBlX2V4dGVudDsNCj4+ICsJc2l6ZV90IGl0ZW1fc2l6ZTsNCj4+ICsJaW50IHJldDsNCj4+ICsN
Cj4+ICsJaXRlbV9zaXplID0gc3RydWN0X3NpemUoc3RyaXBlX2V4dGVudCwgc3RyaWRlcywgbnVt
X3N0cmlwZXMpOw0KPiANCj4gSSBndWVzcyBEYXZpZCBoYXMgYWxyZWFkeSBwb2ludGVkIG91dCB0
aGlzIGNhbiBiZSBkb25lIGF0IGluaXRpYWxpemF0aW9uDQo+IGFuZCBtYWtlIGl0IGNvbnN0Lg0K
DQpXaWxsIGRvDQoNCj4gDQo+PiArDQo+PiArCXN0cmlwZV9leHRlbnQgPSBremFsbG9jKGl0ZW1f
c2l6ZSwgR0ZQX05PRlMpOw0KPj4gKwlpZiAoIXN0cmlwZV9leHRlbnQpIHsNCj4+ICsJCWJ0cmZz
X2Fib3J0X3RyYW5zYWN0aW9uKHRyYW5zLCAtRU5PTUVNKTsNCj4+ICsJCWJ0cmZzX2VuZF90cmFu
c2FjdGlvbih0cmFucyk7DQo+PiArCQlyZXR1cm4gLUVOT01FTTsNCj4+ICsJfQ0KPj4gKw0KPj4g
KwlidHJmc19zZXRfc3RhY2tfc3RyaXBlX2V4dGVudF9lbmNvZGluZyhzdHJpcGVfZXh0ZW50LCBl
bmNvZGluZyk7DQo+PiArCWZvciAoaW50IGkgPSAwOyBpIDwgbnVtX3N0cmlwZXM7IGkrKykgew0K
Pj4gKwkJdTY0IGRldmlkID0gYmlvYy0+c3RyaXBlc1tpXS5kZXYtPmRldmlkOw0KPj4gKwkJdTY0
IHBoeXNpY2FsID0gYmlvYy0+c3RyaXBlc1tpXS5waHlzaWNhbDsNCj4+ICsJCXU2NCBsZW5ndGgg
PSBiaW9jLT5zdHJpcGVzW2ldLmxlbmd0aDsNCj4+ICsJCXN0cnVjdCBidHJmc19yYWlkX3N0cmlk
ZSAqcmFpZF9zdHJpZGUgPQ0KPj4gKwkJCQkJCSZzdHJpcGVfZXh0ZW50LT5zdHJpZGVzW2ldOw0K
Pj4gKw0KPj4gKwkJaWYgKGxlbmd0aCA9PSAwKQ0KPj4gKwkJCWxlbmd0aCA9IGJpb2MtPnNpemU7
DQo+PiArDQo+PiArCQlidHJmc19zZXRfc3RhY2tfcmFpZF9zdHJpZGVfZGV2aWQocmFpZF9zdHJp
ZGUsIGRldmlkKTsNCj4+ICsJCWJ0cmZzX3NldF9zdGFja19yYWlkX3N0cmlkZV9waHlzaWNhbChy
YWlkX3N0cmlkZSwgcGh5c2ljYWwpOw0KPj4gKwkJYnRyZnNfc2V0X3N0YWNrX3JhaWRfc3RyaWRl
X2xlbmd0aChyYWlkX3N0cmlkZSwgbGVuZ3RoKTsNCj4+ICsJfQ0KPj4gKw0KPj4gKwlzdHJpcGVf
a2V5Lm9iamVjdGlkID0gYmlvYy0+bG9naWNhbDsNCj4+ICsJc3RyaXBlX2tleS50eXBlID0gQlRS
RlNfUkFJRF9TVFJJUEVfS0VZOw0KPj4gKwlzdHJpcGVfa2V5Lm9mZnNldCA9IGJpb2MtPnNpemU7
DQo+PiArDQo+PiArCXJldCA9IGJ0cmZzX2luc2VydF9pdGVtKHRyYW5zLCBzdHJpcGVfcm9vdCwg
JnN0cmlwZV9rZXksIHN0cmlwZV9leHRlbnQsDQo+PiArCQkJCWl0ZW1fc2l6ZSk7DQo+IA0KPiBI
YXZlIHlvdSB0ZXN0ZWQgaW4gbmVhci1yZWFsLXdvcmxkIG9uIGhvdyBjb250aW5vdXMgdGhlIFJT
VCBpdGVtcyBjb3VsZA0KPiBiZSBmb3IgUkFJRDAvUkFJRDEwPw0KPiANCj4gTXkgY29uY2VybiBo
ZXJlIGlzLCB3ZSBtYXkgd2FudCB0byB0cnkgb3VyIGJlc3QgdG8gcmVkdWNlIHRoZSBzaXplIG9m
DQo+IFJTVCwgZHVlIHRvIHRoZSA2NEsgQlRSRlNfU1RSSVBFX0xFTi4NCj4gDQoNClRoZXJlIGFy
ZSB0d28gdGhpbmdzIEkgY2FuIGRvIGZvciBpdC4gRmlyc3QgaXMgdHJ5aW5nIHRvIG1lcmdlIGNv
bnRpZ3V1cyANClJTVCBpdGVtcyBhbmQgc2Vjb25kIG1ha2UgQlRSRlNfU1RSSVBFX0xFTiBhIG1r
ZnMgdGltZSBjb25zdGFudCBpbnN0ZWFkIA0Kb2YgYSBjb21waWxlIHRpbWUgY29uc3RhbnQuDQoN
CkJ1dCBib3RoIGNhbiBiZSBkb25lIGluIGEgc2Vjb25kIHN0ZXAuDQoNCj4+ICsJc3dpdGNoICht
YXBfdHlwZSAmIEJUUkZTX0JMT0NLX0dST1VQX1BST0ZJTEVfTUFTSykgew0KPj4gKwljYXNlIEJU
UkZTX0JMT0NLX0dST1VQX0RVUDoNCj4+ICsJY2FzZSBCVFJGU19CTE9DS19HUk9VUF9SQUlEMToN
Cj4+ICsJY2FzZSBCVFJGU19CTE9DS19HUk9VUF9SQUlEMUMzOg0KPj4gKwljYXNlIEJUUkZTX0JM
T0NLX0dST1VQX1JBSUQxQzQ6DQo+PiArCQlyZXQgPSBidHJmc19pbnNlcnRfbWlycm9yZWRfcmFp
ZF9leHRlbnRzKHRyYW5zLCBvcmRlcmVkX2V4dGVudCwNCj4+ICsJCQkJCQkJIG1hcF90eXBlKTsN
Cj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIEJUUkZTX0JMT0NLX0dST1VQX1JBSUQwOg0KPj4gKwkJ
cmV0ID0gYnRyZnNfaW5zZXJ0X3N0cmlwZWRfcmFpZF9leHRlbnRzKHRyYW5zLCBvcmRlcmVkX2V4
dGVudCwNCj4+ICsJCQkJCQkJbWFwX3R5cGUpOw0KPj4gKwkJYnJlYWs7DQo+PiArCWNhc2UgQlRS
RlNfQkxPQ0tfR1JPVVBfUkFJRDEwOg0KPj4gKwkJcmV0ID0gYnRyZnNfaW5zZXJ0X3N0cmlwZWRf
bWlycm9yZWRfcmFpZF9leHRlbnRzKHRyYW5zLCBvcmRlcmVkX2V4dGVudCwgbWFwX3R5cGUpOw0K
Pj4gKwkJYnJlYWs7DQo+PiArCWRlZmF1bHQ6DQo+PiArCQlyZXQgPSAtRUlOVkFMOw0KPiANCj4g
TWF5YmUgd2Ugd2FudCB0byBiZSBhIGxpdHRsZSBtb3JlIG5vaXN5Pw0KDQpPSy4NCg0K
