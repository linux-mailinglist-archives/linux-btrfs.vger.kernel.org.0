Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89D355F2F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 01:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhDFXBq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 19:01:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49976 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhDFXBp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 19:01:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136MxVMh020017;
        Tue, 6 Apr 2021 23:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=w4gy0zH8zD3oAoUj9J8n+EcdB/vKsMEGQBb9gfrW+V8=;
 b=KajGc2822DQNEbnZqW9FFoYgNRN+wyupFq/wcxA/baVWOiNX3udEFi1ntdGkQKVYg9Bf
 1BrDM6EbhX3sdcH1q+lfPkGQpQZoBAaTOZJssNBFV9rQ+7xEYf86uahGw9W6l6Jz/ci8
 EaZgFwBXYXHTd2g3MtzqxfQ67JSMzuuswg+AvtPD6iJ/YWX90uB9oinjw35h5omqAx0m
 ZD2JtH2YO3SRP7q+3cHRNcOd/ZwcirdOOjKRgFjSt7KkpTQMHN7A0cJwedOTVBnis4Wv
 m806Wxqe1Ws4pDCvbNc5ZBmZKvjqhyCNMuzCTxLdX8xDYNMtm5AfjZ0g0XAuyKCSO2u/ gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37rvaw0qvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 23:01:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136N13r7122151;
        Tue, 6 Apr 2021 23:01:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3020.oracle.com with ESMTP id 37rvaxt4sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 23:01:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2ctqHkKvi44pI0Mac/IRsoTHCWCcofkFrhddwrhQJM2XRKWRx38gsaF+euGE+LxRV+po/1E5iKPSsHD7jmbFox/LT84WUmcgLbKmha2A18qokyapU0wURlp9zaVX4sqlZU6Xre66P2osYplHDTo+/vBU4crEX+Q3wccSJRqZG7kw1J9l2hmylXMIlCZDFVVoXzV/1uLK85XvBEhLlUVY9lXssuxuFp14BTZZbVEgTUQiO0u6mussiwsdgceL1TnYMXTauWb77xQ5EW5rFKgmFuArrVwhbkJXJgimos963+jGmybPUktvbShhlm3rg+/iyHDLstMw2vLPELmA6aXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4gy0zH8zD3oAoUj9J8n+EcdB/vKsMEGQBb9gfrW+V8=;
 b=Sa1p99o/+xaPV6I6kWtkw08aial6oXVY3nPv6sIVMEwKlsWexVwZE/Bqp0tS6h+YHlaByTOp5wdC0IZ4oy0NBmORFjXCe/R8ukMQd68yXNcRbEwY52T4dXxqNUzChqD/0T45Be21D5Cxscl5uQOf7OQfdWnBcz2Ipz+Q+kiFMZ01trLG2MMmRD5K0qknto193HYH3mbz1sMUbOakp4ofz0lC5X3UTJwsb6w9ErkNWgU+YrZyF0xsK6jPBHoQmNNanKFEHD4Zkv/sC+q7LoGMExNTioQO4MCkty2ptaGIjP+q9edyKG60Yb3zOzaRoDZosLaX4lmal7Mqy2OkFUp3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4gy0zH8zD3oAoUj9J8n+EcdB/vKsMEGQBb9gfrW+V8=;
 b=OJPcTr0zffRIB4XXKgfHKR6GArcArv1un/0R2qO1SIMxPaHN/UKiAf6Y69re6AR6ixIE0ymZSulfhFG3NDd1GgGG8La5XpjsRUm7MvCRk7IBg9+kXQqzmyuXtrnPI+yV59O8D+hHQfQx070ECLk6KNx+3ogfD9YBrvWQ7G0TkSo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3026.namprd10.prod.outlook.com (2603:10b6:208:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 23:01:14 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::9aa:6ac:8d40:c076%6]) with mapi id 15.20.3977.033; Tue, 6 Apr 2021
 23:01:14 +0000
Subject: Re: [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
To:     dsterba@suse.cz, Su Yue <l@damenly.su>,
        "dsterba@suse.com" <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
 <b0caf058-3bb5-2ceb-d1d4-d352deee636e@oracle.com>
 <83ecd955-560f-14e5-ab97-33e0c0a3d3d0@oracle.com> <a6qdw0jr.fsf@damenly.su>
 <20210406164816.GK7604@suse.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8325002d-f8a6-a9b7-a27d-4cf62cbbc672@oracle.com>
Date:   Wed, 7 Apr 2021 07:01:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210406164816.GK7604@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:e825:e63d:5d8c:fbe6]
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:e825:e63d:5d8c:fbe6] (2406:3003:2006:2288:e825:e63d:5d8c:fbe6) by SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.4 via Frontend Transport; Tue, 6 Apr 2021 23:01:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f6967bc-feab-4524-9fff-08d8f94fe07d
X-MS-TrafficTypeDiagnostic: BL0PR10MB3026:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3026731B5FC5AF08992A03DDE5769@BL0PR10MB3026.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sDncL2V4qQzN3ydlgd0N2pJrvIEroc1+rJFKI05CGk/X9ZikNuSMBG+6lW6opdur2pEbJNrSKJGUYu23+rr//D74u9+T7JfPdksYcWhDtlkS4jaTE6J+lxIHRakeZLZkzjolIS8N5zqG9sfepuEh8Yjz+46sLzcVaxXpAkObl1cZrLj9/F70fLRJs4MWHNIzebQzP+JlcIN4lcr/FTOulIEjCTEDsFC072Cl7clMxIt+b1VLrrgTrHYH5f/FwkTAYC2C+ftqrBgDwLn1zPngpoCIIgLmr9BDRZJ6sS74i8teG5jHMPwf9ymjvxdFNh5Hft9sEwtQ66RWIYSYWXmiMR2Ah4gPGlm2+o7lc0KsQvg/wE9uSMwnoBKlk9zIQI04lA0sH9GruKR2XzYN1ibnmsqkXnSVcWlM0GOY+rGeE1HTyyuhnHRYgSDuiz5V8VZaMg2szC2AJxdEgikH8EflX9OIK/r3P+v/ePo3T7HShjJjHlDrdwUgqGESXqo/fMgleUSh+DLac+XZET27QdKfqgJRh5IChsVJdfe/roQBVVQS5u219346GeyNJi+/O19DpJVXeBpSE74H6ueR11zaL0hOFr3sxNR8kYZY0HIunjk7sv0yeBfHn6ZXv8czGYBksOaMLDaviMTyWUboQdXFS6/FwaFr4Lemqf5WcptML+RiCnCNLTC62JIvN3J7mRKBFT6Wtl13FEdILngdnoSYFB/e4YUiAyJVnqETx/dLP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(376002)(346002)(136003)(66556008)(16526019)(44832011)(2616005)(66476007)(6666004)(53546011)(186003)(2906002)(4744005)(8936002)(66946007)(6486002)(478600001)(8676002)(36756003)(38100700001)(5660300002)(316002)(110136005)(31696002)(31686004)(86362001)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dnVMOXRGNG01NkxDNHBsT1BLSi9Wbm1TMnF2dzVZOHlxWkl6MzV6S2czZWFy?=
 =?utf-8?B?clB1U2k5a3NibkQ0UThodFhmK0lVVFliZ2VZUngyakpiN1Q3RmlOR2VkMlk2?=
 =?utf-8?B?ZEVsYll1NWcwdGpnQlgxTlBXTVhxZmtqOEZSYy9rN3dtQUkvM3FPa2ExSkpB?=
 =?utf-8?B?dkxic3UwMGNjbHFqdkUvSFFjMmNySFNsVE94eVpIeUR6SWZCNnVNWHdGQlp3?=
 =?utf-8?B?TjRvbHAxbmw5bW84Y3VDVTI4cmtUalpwcUIyUnV5MHJBOExGS1BBZ1R3S0NK?=
 =?utf-8?B?aHdNQUlaU3VsVnlMd3FqUzZvWEhQeEhpejlQeHBxZHo2ZlpZT3lVb2hDTlcw?=
 =?utf-8?B?dzY5VXQ4aC9DQitueFAyZ1VxRUdkWmZaT1RZYll0YnVRSWFwNUpLVCtGdWFP?=
 =?utf-8?B?c2JMMGFmakprNzA3QlJiTDcvVHJ2WFA5dE9WVUw1V1M4SVRLS3F3a28xV21m?=
 =?utf-8?B?YTNRa0M3WHUwY2dmTUpqSzE2Z0FJMmMrTHpXWVZ0bXROcXVVc2RhbFR2cUNV?=
 =?utf-8?B?WGlDb2MzbVhLcTZ1V0JiOGdodkQrZkdBVEsybFR2NHN0a09NelFERS9wR0FU?=
 =?utf-8?B?TnJyUkgyMVJpR2tCZC93azRzZEZMMks1S25mbU5UU1lYZXFpNU9KeFpFejlz?=
 =?utf-8?B?MVpSdUZFSnZDV1RvKzdrQ3BVb0lndld5Y1h4eUxjb3V2QmEzb1JLLy8vcklh?=
 =?utf-8?B?dFdVUHlGak44Q2VNZTZSOTB6SkxycUlHNGY0WDFzOHlzTUp1NXMzRHUrL3RT?=
 =?utf-8?B?YXd0YkJMbEtVQW5xK0k3Y2xwc3RnQVg4NmY0dU05N1pQRjRXNWt4bkxocE9z?=
 =?utf-8?B?T3JwRUZPQnJIQ3YzNDZwL0FEUXBIWGpWbVZ5TXpJZGZDRVd3NnBNVGJiS0ZY?=
 =?utf-8?B?SGlkcjdiaXZidHlLVWx6bHlLVXEwdFpsdDJReUhWNitZaXhCZ21rakswcEEy?=
 =?utf-8?B?VEhMZFpUYWlCTzhueVJTaGxjVTZyNjFVa0RWUU9vQVJSWHVMZnZFWEtFR1Y3?=
 =?utf-8?B?RWZtTTBRUWY1bUlYZHpTOUpqTDB3Z1RvbUg4KzhrMC92aGpWVm5hWVdPUUd4?=
 =?utf-8?B?TWVqQUdRK3dhWXg0MkVqcDZRUWtyNkJtcTVubG5vVitRVVJ6VDhyZFdkU1dm?=
 =?utf-8?B?OWtnaTUyRHhhUFdnTHIzdTYrSENWdm9tY2lHTmlPL1ZuaFJETUsrSU5PbVd0?=
 =?utf-8?B?dmh4K1pNTjl4Vjh1VU9ZcGlxN1lYWlZ1Ym5RdTdnM1Z3U2FOOHdiUFpOTTZk?=
 =?utf-8?B?dFJZVkxubEkrMjhHYmZoTm5ycXI2RVBiVnlhRmNMNlNVcENETzhVS3U3WFZS?=
 =?utf-8?B?R0VNUjJyMTVIZkdGaVhSMi92SXkxS25xSG5uZHRpZVJTWGtRM1lFMzZNZ3lL?=
 =?utf-8?B?L3Jwd2lwdXVCbUVlVHIyMzRhVDBSMXV3K2ZQZkJHRmV0ZU9zejI5TVhpbE84?=
 =?utf-8?B?R0dkM2NBWDlQeW40eVZ5Y1pwejFnb0dUOGphbTF3R1hoSEVOMHQzVzQ4b0dL?=
 =?utf-8?B?M29BVGptSXc1a2VMbVZDdGxmbWsvZjRzOWVMNE1jMkVKYzd1dWxwWGl4M0hM?=
 =?utf-8?B?TlFibC90NHhoRVhtMVV1ZHZBeWV6Y0ZhZzVId2RiYjBFVGxFQ2FYNVZLYkFr?=
 =?utf-8?B?azJJeXhEQllteFdvTWd1R2dVc1REamYyaVRjL1Q1NTZ0TUNZdm51UWpVdmh3?=
 =?utf-8?B?ZFlISE1nRWZGUnF5Mi82d01rTWdSVXcxdlVWWXNqS2FYRUhoZVZIQk92SFVF?=
 =?utf-8?B?Vzh3ak9YWDhYZncxcWF3U1BXVHhtOFUxKzRiNldsMkgyd3R1RHkwN25ZYlRI?=
 =?utf-8?B?QnhVanpLbUEvRWg3K2NrZnhZLzBuSWE1VFJXUU45bThPTGNzN3hwMUZxcUZt?=
 =?utf-8?Q?GSqbiMyH5693j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6967bc-feab-4524-9fff-08d8f94fe07d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 23:01:14.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njrA1h9GEd+4MwnR/L3U8UE1RQCBD1PVse4lLRsjQRDk2XFEEOE/i2No9eejNUkfwyjkwnX/Z3erGSlp16syYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3026
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060156
X-Proofpoint-ORIG-GUID: 66YOS84Ab_hi2IvYVmcazgqgNk4t1Cse
X-Proofpoint-GUID: 66YOS84Ab_hi2IvYVmcazgqgNk4t1Cse
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104060156
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/04/2021 00:48, David Sterba wrote:
> On Mon, Apr 05, 2021 at 05:18:32PM +0800, Su Yue wrote:
>>
>> On Mon 05 Apr 2021 at 16:38, Anand Jain <anand.jain@oracle.com>
>> wrote:
>>
>>> Ping again.
>>>
>> It's already queued in misc-next.
> 
>> commit 441737bb30f83914bb8517f52088c0130138d74b (misc-next)
>> Author: Anand Jain <anand.jain@oracle.com>
>> Date:   Fri Jul 17 18:05:25 2020 +0800
> 
> No it's not, you must have checked some very old snapshot of misc-next,
> I don't even have 441737bb30f83914bb8517f52088c0130138d74b in my stale
> commit objects so it's been 'git gc'ed already.

What is holding this patch from the integration?

Thanks, Anand

