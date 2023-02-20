Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C44C69CA98
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 13:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBTMQj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 07:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjBTMQW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 07:16:22 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A61B33A
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 04:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676895381; x=1708431381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=j7N/XNSXpPPfdtKYkQgckdofmi3XS6/cd7I8q8nJmpF7D9VrQ86vPbhU
   RcPObROhBFt1vo5/klqxlbhbXcMZxRlU9y0YE6q5WnyqQBuuSmannMMqV
   mDhdxnAuz6vjDDWG+i76SRresLK7yO5pvyDy0s1dWcXJi2lCBcU2e4zLj
   Y0vo1thKaOifd3ZwgMZj5junj0R1rZye/yehldGsB1cdpdjbDjjavUkcC
   qcCnYf/RGNQSceD0gGdgMs4xNxb7uDJ3vQOMwNTsUm0h3isE0NGMcloAR
   DNVuddCbxFPFMWlDLDxFEBP0/7XfdUkG2qL38ZQKTrz3bEhvQokAB3YK+
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="335699743"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 20:16:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S96fgaXoGsvCsQMMrguscM8HxLXP9r54wY5KAQLIwiiS9I0KIuK5Es7QXihAXVFw1KiAcEYFWgWel20n2AQmOsZ+/yG59jGqOi8VGdyAB/YKezL2BCxLbw93Vb2ejZNmhs6IkeBGXhLeELf4EzLn8urR2svyxI2XjnYpqUEp5bKWvA099rdnyDnHG/9YFhXH0IUx11WjPVnqu7rmMPc16a+YjzQAzscCYkSylkBzlL2RPg552Yp0Kgs3vx9W7/OCm87FpSC+ecQXFwr4kpK8/uv0rh+LFk7Dj6+Vv9aCtC0VTKcFg62wU69Am9v6MxdVSY+NAu8wzCKkrFeHy5BHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=J4ywXY2tevfFK0SUAHkyDaN3L8fUVE24vVXEaH1aqO4SWvB6gmnhg83iVmLQNBhkjYiHflj/EK4JGXWUHxqJa3H+w9X/kT0avk9/jd4VkKlUMaKLSmVqsWihXkfRe3RyZQCMw6ys7+gvKTImwmtV2Nueyw7dD/4r1qwnyUysHc6DE58SZ4KwuK/vZNKLZRhZss4biiclMOay/SBYHNFESV/UkqEQ7wJ+eyGm94FCwgixqLUGNiX+E+KWZo9lmDVFUxiHrOFpE13opUHsHZf5FvYPbnU1Si4QgcVrTo7H8s0CgFKyWcCROG0+nwkQOqEQfWPD3l3h+YGkrIt8AFs+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FkUBD848a33ymvUCiYgGjn/93H4dkC/r7EIU2eAO6mp2//8c465l2CK+xf8P55PnL2MzR3s6Z5tkc0Gk5T3z9vpCvaVLM6w0oqRq/xf/PcU6nZj4izf4T5DIKShmqqah4z7zd7YNvlENELtFmmYe/X1kvF4HJDbvC1LKDD8XfVY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB5440.namprd04.prod.outlook.com (2603:10b6:805:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 12:16:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 12:16:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/12] btrfs: simplify the error handling in
 __extent_writepage_io
Thread-Topic: [PATCH 10/12] btrfs: simplify the error handling in
 __extent_writepage_io
Thread-Index: AQHZQiTJqQnTDj/teE+s99LUYZmZJK7XxfkA
Date:   Mon, 20 Feb 2023 12:16:17 +0000
Message-ID: <4acc638b-6afb-4270-11d9-b225b7452af9@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-11-hch@lst.de>
In-Reply-To: <20230216163437.2370948-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB5440:EE_
x-ms-office365-filtering-correlation-id: 7eb96e67-f5b0-4bc6-a648-08db133c447c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BwdCRp7oUHvVUDRAB4l1pFoFRZJO24FOK3QOjEiu7LX4innNfNmz6oUvSg2W7ZPcOUfT0VMGGH2AYkSf23slwT8bVp5EBl8KeFjY7GBxxY0jeMHypozkyGqaCrxMD7ZlP23BiugXIvcV7vQzoflxhczdBHsSXi6vRQlNOVzTItb+hJRZmymM3iNEYmMZg6vQn9ZZNrFHIxLUwD5YI2YHpyrvKarFBLFL5oiZTRnqJYEJGSlmkAxivB6bqRfkMmVQzK3Ka/kqVd16B4eLU3BiecXkxmABhroCJfA1Ptv+7cohxEHpnoFSPDvx/OdJdGFfSVVJ8fF0dNeIJobzwfA6IcDQqPpkw8z3btTp0Rg/fzzB9CieQtVxMKn8PTtV6Ly+n11OnKi26f1rz0egUc4PiqEMBQcX9pv/jifqovS3ZDt5xgKRCVAaGxQ2gLfNVUKWxqTx/bEMF0udr94rUhMxVXtEvmGCP0YnsHBzuq3HDj1y09yAl0hodxY43ncDd1a8bkpnzxWYDyWRZUwTOndXkBn/oV5wdJ8NuQvwuOPf2X/Z9pa9XyK7kjTKtKtpJYJnFBBMtuq4gWj5fQsMkjX7/O8sJtt/bZGL5wz9H3uMhNGyctW9l4lNfpEa07jJ/Wqq/nd0xFPfnwJlw+kmOdU3Tk7+s6IILUqCDW70VO7lw+BzaxlKaRx/DWhtHF9MkXQ02Ojfnjx2hTI/2+7PcP1l5EDCvUuXP56sYnAHHGeich6C1uIy/chmp3Wahu2SJ2WgPnUCbGQgfnCd2wSwTozdeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199018)(36756003)(478600001)(110136005)(71200400001)(19618925003)(122000001)(82960400001)(38100700002)(31696002)(86362001)(2906002)(38070700005)(558084003)(316002)(41300700001)(5660300002)(8936002)(8676002)(64756008)(66446008)(4326008)(66476007)(76116006)(66946007)(91956017)(6486002)(6506007)(66556008)(6512007)(2616005)(4270600006)(31686004)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0NhcnN6MDZDVE53L1cxeHFmdEV1Y24vankwTmRMS0tYOC9naktPVHFmTkpU?=
 =?utf-8?B?dkljQU9IeEdrbGczanh4MFFrWVh6S1JkRDJYbkVRanhINk83c3IrS1FWd2Rl?=
 =?utf-8?B?VjFqQm9vRnZMc28weWR0cFNJWnA3dFhqZytTcUc3TXl0MVlpSDlTYTB4OTJR?=
 =?utf-8?B?Q1VRUTdxMllmbW5QbVloY1dGRHNJNW0zZW1rYXBYVTI0c3c2YS93ZlFLaysr?=
 =?utf-8?B?QU1TekNkU3hsYm1oQzBnVmFYQUwxWDlzOTBQaEdTUFMwMlJaQmJXMUZXTmJi?=
 =?utf-8?B?eHY4S3IrSUt5SWhWYWlaRHgzczRXZ21pWE1jbG50MnlxVUsxK2NxZStySFF4?=
 =?utf-8?B?eFZhZWRQSjlPMW16RGExRDlRL2dnV2JjQlhZTDRKZmxWd2pDaXVLM1FtVVlo?=
 =?utf-8?B?Tjc2QVNxWXVRb1JRQktqRHRPQmVGZjF1OG8yMElrK1dGM0tDbjlpNzJCS2Mr?=
 =?utf-8?B?bUEzL1gzek9Ga1A4SUQxRy9TbktXTzIxUU1lUVQwZTdmMHpDZFdMOVZWY2Jr?=
 =?utf-8?B?am51QjI5aVpYRG9CZTYwdDF4bWR6cjNVNWE2SlN1STRiK2s2M095NHo0czJy?=
 =?utf-8?B?bGdlejUySDgwRHBub3BIL2llcElWREpwSU43Qm9SNmdaZTBEb0pwS0k5OEhp?=
 =?utf-8?B?WVJOYWE1bmcyK2lRNFUyMjV6eFJhVVJCQlZBY0F4S01IaTdTdmNOWFBzbXJG?=
 =?utf-8?B?YnYxc2p4WEMzRk9jdXRSNitGMjArcit4aFY0ZVdVRTA2N1Ywc3pjWnlXN2xX?=
 =?utf-8?B?M0pFaXcxN1JIZ0R3cVR4VHk4SEV3SVlqd3JhU2wrcEoxa2dYSnpTSGFuK3pO?=
 =?utf-8?B?UlY1RlJoSHRGRnRISXUxWVBiOWp0VDFxUTdBb0p4N3J5YVk0cVJJdHJIV2tQ?=
 =?utf-8?B?dlVYT1NCYkIxVTc1S3ZjOFFTcVdtZ25tdVFXWjF2dDRxbTdJT3dCKzBWVTRa?=
 =?utf-8?B?YVp1M2hlQ1pFbWpuUGwzdzA5N2YyQWxlVkF1RW40UGhlZy8vU2s4UnBtdjJN?=
 =?utf-8?B?cFRQWVJjRjdpKzFBa3IxNDg3L2pteDU1U2MreVRhT1hmTGdSRit6ZzVRZTgx?=
 =?utf-8?B?K1Z4a1RmVmczbDVGcHZMWHRteGZKck9pOEw1TG1rQlNmOHZMaW9FMEVtc09R?=
 =?utf-8?B?MCtUbktDc0M4OVVmR2JBaXdxSGpZYjVTOU0zV1c3eDBSaUlYMmlkeHEyNnN3?=
 =?utf-8?B?MGVod2xEOVlzdzVCVlB0N2hJajFQenFtWFdnN1o0Y1VxaUx1cEJVcFM4WElS?=
 =?utf-8?B?WDJuc2RKY3dXeDNzQUdKZXBINXJCUzZyWlhOVU5vS253NU9lM1BVMEx2NnVh?=
 =?utf-8?B?ZDRYSndyaVFYVkR2T2dySkVSMFFJYkkrQWEvRlk4cEQrV0hONDd5U2tFN2xl?=
 =?utf-8?B?Z00rVHhNYkVDbXBRWkY4RzQ4MkxvUzVkbnlWYnpPazdPQXVodW5xb1JWS3ZR?=
 =?utf-8?B?MU5YeHRXNW5BclJuUXI1a2ZUTVA3RXJxR1NiM3N1Q2pNUUprM1dXSmlnN3RV?=
 =?utf-8?B?T3dGLzU1V25CZ1cvRlBPOVp2TXEyY0twdWJvZWtidy8zV2tGbi9CWjI5d2pU?=
 =?utf-8?B?YzZ4K1Rsa1VhTGZXMm5GR0szamZINXBvZGtqajE0RDZEc2x5QkNVeGwzVUZz?=
 =?utf-8?B?ckNUUEtqdFBkd0luUnV4T1lJS0VQZ0FhQS8yYjFiaFhUSlV0TXlXc0NhS0tE?=
 =?utf-8?B?c2FWd0c3a1lvL1k5N0dpV2NrNlNtOHR3V1hKM0JmVGcyWWxIOFVpeXlyUDF0?=
 =?utf-8?B?MjFkb21tdlNZQkw0OU1rcDF3TWc0MHdRT1V0a3cwUDhQd0VZd1prbTJsekZ4?=
 =?utf-8?B?dFBVeVNVeW9EcUVFaXZXV3BzbldIZ3FzY2hIck5TK0ljVDRwRzU0aG0xLzBm?=
 =?utf-8?B?T2Rwd1d5TExrU3pSSk5PaTcrVFgvOFdjbno1Nzh0U3BqaWhnNXh3blVaS05i?=
 =?utf-8?B?OENGbkdmM09Da05JaVU1MTFVaTdqZVlqYmpZdkYwc0hWb3l2Qlg2N2FxWmFL?=
 =?utf-8?B?U1pHbVJDVm04ZGdGWC92anZiTkhmL1Zselp6V0JwNERBTXRPMkxDVzFEcDRm?=
 =?utf-8?B?WWZ6bnB1STd1OVJjV3pLMENkUFZRVktwdGZ5M29BOVBFei9QM09CQlJzWnNu?=
 =?utf-8?B?T1JUYXJGUnV4bFdzNWFST1VML2NiZW1nKzJNdk1POFJiSHUxbGZJeUowaDdG?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43CA9345E50FFF4B9F56A5D76F998AB6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kjJ+bPyDDQk4Iw82TZ8PJu+roihqKX8yMxAnr8x5ntR4Z9rXepsZ4r0XhOF4/gA0QqigpR5lKaLMHH0EmlXdwpsf0Ims1z9o9zFbF8NLpIYqbKP6RXhd9vD3INHRxeb0O3ODsAnKYwTVLwQPT0EI3su1QdQ7uGHi2+EhNwpnuBGikzZ7OBr8ilQsaPfe2tXWMTxeP2fG6OYX+oOg9kGITmsuYGYXTovbmkm+vd+vzPU0ejAW6mvI7QNudceZt64Xf3O527JD3OH1i0aK+a0Q2qaJwASUxY+QDGUA9kBR1jJjqKuCqLwxWZVf6WvB/Kgppm2EzRK2dw42XJj4hKx2BVXEgwDgaFAzIVtzaQQMNgnzKbRSm5mWMXwBdqp8VA8jd+qQHhBzkmS96ort162azt6EsNvLe/16I1MebgMKeQ+98KYRWB4OdM/WJsLheaWxPWwWXr7l/p1mTePBH801U0jIuE+NeQQt6vEfhwaJykeP5fuBBc+zoLvQm9vZgVg/0kf3dcm42o4QQ9/HJOFApS9xrrOHVbmMy1kcv0gLuDe6nr42lOGaG/xNeyDAViHesRXduBMIU0b54+U6yWNB82nMuXA0va/IPHP3N5LmBFJhtTd+2hqgLFlFXJl4oy6gTHybUDILL1bGPt8IUipALej95SJfqtWYHLTMzV9VPDCsD03M8+X3Feyg55J2e3yufLTjuKZiAKR/uLSSTEGy0NLEJUHcgoAS3HIOEw6OMuOPxImRVE6rdyArdLJbpU9mbpVaj8ZxExS7wdbPlpbbYlkDMgGGK0qxXUP3laPsrI/ACR6wsfDey2VgEhdvfBHVcmSILKMa3+VmOv1sXFFMgYpyTHFUjmBEc+a3M2gWh3UpoeG/scwOb/juYx68e/d0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb96e67-f5b0-4bc6-a648-08db133c447c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 12:16:17.0573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/OWtzx2dis6v+1nLhYOY8bg/OrZHURzdIDvavz8locHPzMqwDVKEkINEkgECVQ3KI8ql7sIf6oUbUe5D8+tsJ4UAl+Hy7l5Vo/wx5eHSms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5440
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
