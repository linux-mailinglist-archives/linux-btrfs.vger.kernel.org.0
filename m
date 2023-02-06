Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3062D68B7C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 09:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBFI4E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 03:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBFI4D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 03:56:03 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47A4C1E
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 00:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675673762; x=1707209762;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Kg5Xgv1N+xKXiV1s99lmh4hSEotIuNs0AeRj3P/mUn4=;
  b=gHsde5Zv456Q7j6A15K4PIge3FEmjwec5AAP5GHW1nkT3q1I7qtVnm5z
   obZ6BXeKFqjeAscecSiDPDd7qAi0wzqv8i62RUNkqJxM0tdFoj3TzTzgf
   4yU6U/CeefrCAKkVxRvH/woFBnkIxuERhqLn48EJZONAWYCbahUHEP3lr
   7ZldxYeicxGLHin55WRYHltw7mLkKl1WtxdhfgHGVFeF9eVFjsx0zdbak
   xJy/gMeGsJdcz7bBwLtnWrA9odRBDpATag5modvRMx5sRXO9eIfy7zS5e
   rzampQutcVeeS9SZAarfirazkcmOHIV+dPhG6hO0F2a0TFFBhQouOpBCq
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669046400"; 
   d="scan'208";a="227572104"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2023 16:56:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjFrR7T1uZ99mxprtf9R2If15ZxGTOsOSRsGSUzVgCm/YJek27sIqTguFI+7nnxxbNmuXT0yrvABVC+5Fu5gTH9PxbV9LF7eMpvR9ZAEVqtMn23BrysE8s21r6Fm3WQxl7lmCJEX0tOiisabav8arxN3xGO0h30YX4dgXZzPNUB5hWypZHvRz9HU8ft7dpXzVBIOs9YBhd5u2U8/DBs9KitcCOQvERf1TJD243kjsbGHctzSiQBtDMZZc+X4w8Gla8cJrS+v4f5O3gwG6w1owk1mkPCCjYy98Etz8+1GIVNO1i066srRtFcGt4SRO3d6VyPV2AyMmZYO3vEi4bAYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg5Xgv1N+xKXiV1s99lmh4hSEotIuNs0AeRj3P/mUn4=;
 b=Y/CQ3TG/lAZ9AKfcZxGfFqYPSnT51+Wfne2tO+yCE/hmer+KIjZEHF19qJgLz0iusvTYEmkgHLNh2jB0lWkyHZuYPr21XHZ4i86NiUgFQ2iCVaNdbl8hrgAdetB6pWqJZHPoA5P44ViBBZMA4XYxPlSEc8HzpzHMlZJ6U3dJKp7IpjpDzO3nT/Vpsu5RwOFhOh/9p0iKqmkWerc9DbAUqsPIlrYBQdlQlU3m6XHjpHuLbcb7/kxb1fGHP3JsVaRRJco0NUW9k62oc3lHK8ltjM3UZXSTG8bviOMloqKnM9EF+wug9bdXujq4T50/x6MxnvAvqp/EffZ4fhWtDO9hQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg5Xgv1N+xKXiV1s99lmh4hSEotIuNs0AeRj3P/mUn4=;
 b=OvzYiZ7UFsD9qDuN2St1QDjFDsz3XpgYvTk19SmrNvILQHdNFtNpq5pToj2+PSz6jpO142DgxZ+WmRvWa6W8hPbFdhJroVxnRLrBLGG6xtlbMf5PlG+cq6w9msQbltB1+3XjPHGsQqkJzmcKrFdEug5mlEmnWrXhAZz+GEO6A0w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7520.namprd04.prod.outlook.com (2603:10b6:a03:329::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:56:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 08:56:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: remove map_lookup->stripe_len
Thread-Topic: [PATCH 1/2] btrfs: remove map_lookup->stripe_len
Thread-Index: AQHZOT9r6K57sQLhwUek5dODckeiSa7Bl1qAgAAGZQCAAAFrgA==
Date:   Mon, 6 Feb 2023 08:56:00 +0000
Message-ID: <28fd1afc-47cb-b756-77fa-fc0059d0e49a@wdc.com>
References: <cover.1675586554.git.wqu@suse.com>
 <0da7fb8df029231aa8f65dc1d0b377e9a91f91f5.1675586554.git.wqu@suse.com>
 <a08c7ae8-b31a-55aa-fbd4-9db441c0c416@wdc.com>
 <742b0199-c27a-80e3-7f89-3165ba7ba362@suse.com>
In-Reply-To: <742b0199-c27a-80e3-7f89-3165ba7ba362@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7520:EE_
x-ms-office365-filtering-correlation-id: 23baf0a4-5865-4d47-3d75-08db081ff800
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y7IeAIK+biAgmr5LZNSUfD7Fec3ACDBfZAK08IcCgCofA1tK9SgfavTOhMk6JUpofoJoZiVaqd2/beyw8esM1bDJ2NyRmLfohvzpYJjVknfii3L018U1aVYbpHEUICMGdvnoPs4TPpKhWzVMMhDYLvBZ1BQNoVycTz6495qm/29WzrJf4RgZb6h1G/sGLdNaX6mqOdUSVgna/T6RzysiHorzymfuLKjsSQmuJXhwxn46qCJLYfyIE6u82aZu8oKPPBaA3TrCHi8fkwGhUEiCmllY0u1xBATc6Jt2XpTFDU9Pe3kL3irxIHYClcrNBeQwcwL8b7wt/fhdL/dexuq9Cb4yBvQbCDI7ipncgMOTF2vJmngJOj9ObZE4JstunE5WiixDYnWxrG9/Yfcj8o5j4zVUwdIHz8ePs7l0Ja77iWDKV99taGlxHUQ6pFs4aQb/vSHhtvKZuxwUSXjG4A8t0FbP0FJy0zVVedywx4sNTxRa3PMAn8n25n8Nn+CdJy79lGtCnrilBUd7J7GMQu3qOBN3o6XWhliruFihFo/WYdtOCUa56eyfy2kOLngJJhwg7D926UYSMpiNjV1elmv21oJungvbMvZl4IZ9VO0MaVGiubgkGBlu7SU8aFWAfqV8zijBV8SYxDyoB5i1m+4LtNuzG8EEM1VKosSSv9MAZI5gc9RWjth/LhVMhfENKVmrr1BZ5q26mUpiciTPgy4HiPFcHUWGq8FcBYvtF3tPIG0vZNMr/gozt7PS65G6khs4WYqWUFGfpPh1Dyk+2prmdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199018)(316002)(110136005)(31696002)(6512007)(86362001)(71200400001)(36756003)(31686004)(186003)(2906002)(64756008)(66446008)(66556008)(8936002)(8676002)(5660300002)(41300700001)(478600001)(2616005)(6486002)(53546011)(6506007)(38100700002)(76116006)(82960400001)(66476007)(83380400001)(38070700005)(66946007)(91956017)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0tDKzVtanIvZkFTc1RTdng3ZUpLZXBrVzMvTXVIRTd5c1p4L1lndTN6WE13?=
 =?utf-8?B?OG5nbWpWUGhlUzdNWFJaWUYwWmp6MkJvaVJrVVdVUjEwSUlUTGExMGdEUzg0?=
 =?utf-8?B?YlBjcDlIdmZsYTBZNHB0cld1UGM1eThBV1piM0ViRFhlQTBpMUt1eG9pbGZo?=
 =?utf-8?B?d1VmOWowNFdpS2tpbENTMTA5NnNmQ25xS0tvc3h3WldnQlBnVmRFTnZmZnBB?=
 =?utf-8?B?djdXQlFhb2w4Y0diRHpjZHRZTm53dGlnMkFSSUhwK2M2WUJWZmJSZ28wNzFr?=
 =?utf-8?B?OG5UdWR2c2lmNnJNZlpzdlpGcWlSSHFSNHpCNk9mdzNxQzRERWIvdS8wSW9k?=
 =?utf-8?B?VnZ3QnVpQnNKREI4eW5RRnhBbXN4L0lyblJSUmkzdDJ5TlQrbER6dzBPN1Zs?=
 =?utf-8?B?VkR5WlN5VzlEQlg0K1o0bkw5cGh4SWlpdm40SDFkV0s1V0o0WGtBNHFoNkhv?=
 =?utf-8?B?dE9vMndHWUg0cVBZSGw4OUhSaHZmb2MvNVF0TEQxUGFJQTNOZVBMdm5STTJ0?=
 =?utf-8?B?a25GNTZQcEZNUHJmc2Z6V2NWNThvYVE1anhyQ1RVV0YvWm0rZjQ2aG56eVhB?=
 =?utf-8?B?NnR4N1c3Q1RvSDVkZ3REYXFYT0doMElDQTdiYi83QWhlblVaKzY2dVRHNmRK?=
 =?utf-8?B?bGVvcXBDNy9SSXpMbFhzc200VlljZXRRUUw0Sm5ic2JkQXN4aDV4bHpzcHR1?=
 =?utf-8?B?NVgycnZ4RXAyeENHaDM1MTBVeDloL0IyZi9CU2VmaGpENVBFd09ORFNyN3ln?=
 =?utf-8?B?bWhkaFdIZXJwdUtISlNPWUhkN216Mm9JenRkeWlPa2ZuWDRkdFRMclNGNWJW?=
 =?utf-8?B?UVlLNVVOQVo2YmlwNEVNQ0Q0RDhNTzFSRmNQMmhEdjJCQU8rWm9pLzl4aFBl?=
 =?utf-8?B?eUh3b0d5emtkaWRQeDdlTUl2M2NRTDQwYVNNMVExMkozVjhzaFhJOHcwclJh?=
 =?utf-8?B?MjJXM2RlaEUwOGovTGZTNjd2WnRtKzRhZ3dsUS9wTjM3cXJqMThXZVVVTlFx?=
 =?utf-8?B?NjNmMWx4ZkRBYTdUTmNyd1ppWmxmY05TR1J2M0NRbXlxR3hjQlczVnJlWnVa?=
 =?utf-8?B?eUFsNG5DUkdsdkFFcHdNVnQ4cWkrY2N1cVo5b3owTzh3YVM4Nm95dEJZUlU3?=
 =?utf-8?B?MzVqK2l3NnZ0UG9xSm9lc3JEN3lTVmFYSjdQUUtpcEc4cjVPUmh6V3pkMzVh?=
 =?utf-8?B?cVlUKy8wcUhBRGhqMTVGQzlwYlEvL253RmZWNnl6aCtqWG81bHFwTDBIQ05S?=
 =?utf-8?B?QkdmMkFaYkl6V0U1Zmc3aFZzLyt0M2JmQjExdFBjSyt3QnpwSWxzWGx5WFA2?=
 =?utf-8?B?WTB4OEhEcHlRRlZHMnRoa3ZNWko2SVJpNTQwRlRwVDNxM21oWE93MVNaS014?=
 =?utf-8?B?cG8wYzRPLzZPMVM5Qy83R3liMzc5bE5NcGg0eXo4QUY4eTkxMEVlV05LN0Vl?=
 =?utf-8?B?YjJBOTdIMHMrVU9zVHFjZWVNZ3U4VzJFMTRNK0VSbzJWYkEwZXZXZWwyU28v?=
 =?utf-8?B?VFpXUUVSVlZUZlVjK1l6bGtWSHVsUXJIL05pRWJ4YU52bDVqaGx0dDRaMTBJ?=
 =?utf-8?B?Sk51RkJ0d1lDQjBNRUYvd0k1M0FZZ0lDWWQ5SCtjeUwrRUNSV0t3N3F3ZEd5?=
 =?utf-8?B?Yk9JNVNhM2V6RUhEN3NCRzNzbFBnR0VTakFobkRzUVY3VFVvVnR3bElzUXJU?=
 =?utf-8?B?bGxMYm01RGQ1bVR4TjZLMERIRFQvMG1rTnZuSWFkc2VBazN6UkN0cXJORVRi?=
 =?utf-8?B?NTlQUngyS2xybXFXQmg5c096SWIvQktCS0VPMWVxdkdyVnBjcmhsRlV3QW5U?=
 =?utf-8?B?aU1od2o2cjczRW1pVjgwc2V1ZXcvWmJxMkErdU1WU3NIaDlBVmYyejYxcHFz?=
 =?utf-8?B?MFNEWVpLajNwL3psRHJRYU1Ra2d4TFUyQkxBTURsdGJVVGdPUmRISEhWNmRY?=
 =?utf-8?B?TThTTjlnb0xhNzVCQzdubU1LTDU0YzR6dWdsVTZxM28rbFJLLzg2K1R1OERZ?=
 =?utf-8?B?Y2pWdkY3Y0IwRHJUaTA3dGRHR0VIZ2FxZUNYT052REdjQ09RaGE4L2JxVG52?=
 =?utf-8?B?ZWxOblcrb3dUblJzTkZwdTAxa2tsdWg0cS9HYlp6eDUxQitRVFIxTjF3K0NK?=
 =?utf-8?B?QXgrWjlLeVdBajRGajlIeHNyWFo2RTRtNkVYMHhDUmxGS0xvV2lSd1FSME5a?=
 =?utf-8?B?MGJaOHRFWitQZHJtMERSTTZpZ09BeVZzMnNZMDRDN09ZQ1NCM3lNL3YwNUNR?=
 =?utf-8?Q?zmRh7P0By5xwRtEznmlo+/xSG4Pja9gD8gOaMuG2JM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4AA92D2775A5D419B3BD3A9BAA240B0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: km5VKCOFUGxfW0pc4sW0Y5AHA24V6yLmkYFH/K4So7kyyIJQ3l5iZRnpc48TEAjWw1Rc95DPMq84FhisW9uMpxzC0Xul++Ke5jtwVG2HtMO2tKS5FjczmubYnGJE/9xEiAN4xvdxOQTjZVrPaHtD9s0dLZKb8RsnrSgekLSzGo3mX2UNWQroIfio+JJZWpn+vOrMSOUW3qTFIEOE5OV2vhipv6P9TCnyP1bnbnBvcZ2Q8BJGUXOs3Lvm6eMIN2BlqxIp5PgtdrlqTepclEIF2o/xMywk55KxxRIcoX9hQvPao2EH2rEwR+jJuvi9Nlvuqj3CXsfzQp6T5VyTPRQm/vnOH4JAU8vACr3uOizo7nz/jyTuDEznmWXcmHEGDZ9Bmr/kJFh0cwYS/QG5GabES04MmlvjCCABSCKIGPz372Cro6BfyQav/T0wzovsjcU/cYLKFoKTjmnKqyJbB/BXdDarLmj0/EoF18geIhIzKmAFeg0QbUPGK389v3UWfodPBfXdLuIExZgMWv/QZfinqY+80rn9Z2fMu6oMM/daMsstUVKJBngsXKwOWsBjabGiwYF4zHdnR+PRKNWOj1WX6/FkD5OuYzWWHU8/ZdJv1+S9RvgxTalSaQC3Tte5S+52uylJlziJgBoEpLi6q8PdCabSVZ4nvelxe83PmfL2qMn+1rXY513RoDupBJE2xtKJjQ9PY+88Ns1df3CGo1O8cuB2/mcRVk0p8lYGdcFw2SbqfRFL7bVmZc9uuFeP50W9GrIg8cQuF32ietm91xvcUIFybQwbhNkzPu1ahqA98sc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23baf0a4-5865-4d47-3d75-08db081ff800
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 08:56:00.0362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+ZYGDFdJ+Gkp6PaSHnbNJKuavR8VD8/UH2CfEqui7D/louDlGgmHtXvN9HrNLPZIm61Vlf934cEl4IxFKUojqmQPQz7Oh76FcaQb0qG59A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7520
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDYuMDIuMjMgMDk6NTEsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiBPbiAyMDIzLzIv
NiAxNjoyOCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4gT24gMDUuMDIuMjMgMDk6NTQs
IFF1IFdlbnJ1byB3cm90ZToNCj4+PiBDdXJyZW50bHkgYnRyZnMgZG9lc24ndCBzdXBwb3J0IHN0
cmlwZSBsZW5ndGhzIG90aGVyIHRoYW4gNjRLaUIuDQo+Pj4gVGhpcyBpcyBhbHJlYWR5IGluIHRo
ZSB0cmVlLWNoZWNrZXIuDQo+Pg0KPj4gRG8gd2UgYWN0dWFsbHkgZXZlciB3YW50IHRvIGRvIHZh
cmlhYmxlIGxlbmd0aCBzdHJpcGVzPyBJJ20ganVzdCBhc2tpbmcNCj4+IGZvciBlLmcuIHBhcml0
eSBSQUlELg0KPiANCj4gQW5kIGV2ZW4gaWYgd2UgZ28gc3VwcG9ydCBkaWZmZXJlbnQgc3RyaXBl
IGxlbmd0aCwgd291bGQgaXQgYmUgYSBnbG9iYWwgDQo+IG9uZSAoZXZlcnkgY2h1bmsgc3RpbGwg
Z28gdGhlIHNhbWUgc3RyaXBlIGxlbiwganVzdCBub3QgNjRLKSwgb3IgcmVhbGx5IA0KPiBldmVy
eSBjaHVuayBjYW4gaGF2ZSBpdHMgb3duIHN0cmlwZSBsZW4/DQo+IA0KPiBQZXJzb25hbGx5IHNw
ZWFraW5nLCBJIHByZWZlciB0aGUgbGF0dGVyIG9uZSwgYnV0IHRoYXQgbWVhbnMsIHdlIGhhdmUg
dG8gDQo+IGFkZCBhIG5ldyBtZW1iZXIgaW50byB0aGUgc3VwZXIgYmxvY2ssIHRodXMgbmVlZHMg
YSBuZXcgaW5jb21wYXQgZmxhZyB0aGVuLg0KPiANCj4gSSdtIGFsc28gY3VyaW91cywgZm9yIHRo
ZSBwYXJpdHkgUkFJRCAoaXMgdGhhdCB0aGUgb2xkIHJhaWQgc3RyaXBlIA0KPiB0cmVlPykgaXMg
dGhlcmUgYW55dGhpbmcgcGVuYWx0eSB1c2luZyB0aGUgb2xkIDY0SyBzdHJpcGUgbGVuZ3RoPw0K
DQpObyBJJ20ganVzdCB0aGlua2luZyBvZiBkaWZmZXJlbnQgd2F5cyB0byBoYW5kbGUgUkFJRC4g
Rm9yIGluc3RhbmNlIFpGUycNClJBSUQtWiBoYXMgYSB2YXJpYWJsZSBsZW5ndGggc3RyaXBlIGxl
bmd0aCBzbyBpdCBuZXZlciBuZWVkcyB0byBkbyBzdWItc3RyaXBlDQp3cml0ZXMuDQoNCkkgYWN0
dWFsbHkgaGF2ZSBubyByZWFsIGNsdWUgeWV0IGhvdyB0byBoYW5kbGUgUkFJRDUvNiB3aXRoIHJh
aWQgc3RyaXBlIHRyZWUuDQpOZWVkIHRvIGdldCBSQUlEMC8xLzEwL0RVUCBzdGFibGUgZmlyc3Qu
DQoNCg==
