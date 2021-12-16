Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6096477121
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 12:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhLPLyP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 06:54:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41898 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhLPLyO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 06:54:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG8nHwo007980;
        Thu, 16 Dec 2021 11:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y4itNj4gR9wrXcpvEQIOhoczHzNBg1oJ9+XU3u6Kpp4=;
 b=YzbXWTKgoPO6JKoeklpFw2T/RaSSG2JZ0cXCtGoxpzjLN/hz9sjXSDOzUWutAkbrePSA
 UwUav4ozwMzS4EhoXwFo5ok/aTKpCO5Ta3R1G4JPIv7nSe80LutbyAWXhk8jNRMnTCD6
 /+I1wpyuWrlLvrEbMLkn75BRunn6cVO8C3kD7zx2D0fGpmMkR3O6eK7EabSvmInrQc/v
 AQ1JhEd+D6UF47OwzNKWxkgwQSbplf0yDkP0dPG5eR4cjFqup4yPkEVuJhS2UzVQbNlg
 fwuKJxuHTgZpdLGX6Zjs/Qp0NyENDpXoGpv7GBdNM9JGugoXvVS/bI414Oy5JOpMeEKG 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknc2hm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 11:54:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGBkffN182311;
        Thu, 16 Dec 2021 11:54:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3cvh41uqg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 11:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h26ga+PoW83NJRNiXp4sqzCtJasmiJaRMSB06Jb9D/PcTehoBt7rk43WVutx1hAV57M4tky/fLIGqnQvxzcbFds1EanO5dWULewzHGlfb5juToP5IgwoclqPNJ2qf47kjRoClYF+YkpZ5vL5+E/k89ECYV9wdrKNFcP8+TznvNnlv28wnpzKDabYh1EMztoSnOggNWpNQHYMP1+IP3sCN3p/61bvDE9BVgTabrvnDd4PUr32g8Eql5tF0iOVHYts3te5WOEt62lry5ExKypy7jqkV7s1paHUF+mHk+OcuvZVAYUB78dLH/0w6qGBdXT9Euo0Z9pRjbaBgzlNIRjO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4itNj4gR9wrXcpvEQIOhoczHzNBg1oJ9+XU3u6Kpp4=;
 b=XyuPPCd8XmtfEuT61ug/5Zoe149+opSYxuXBag+4Z/YcYTB4T+TnK0ir6Oq7ZyfSVJegoSoS//C5SJrhj1t2io6+ZvwlbQZv7pFwAyxbkao5XDoU9rWskJENrMRxffUzcd0KpNEWmYukEP7sGoLWlgj7vE+gYRAwnO1zQCtrom5qNVI1XUbI8sUe1ImCK9VTpIE7zLJgp9E5lu5yA9c64z78C/RBYZElSrHxONnoKshUtcaHkjZlX3Wx6ea9vHaVNMW+I/hUJ2BnQVFm5CzKQHsF5ZY0pfoHiOylZztTK2p+SQvWHMGWZQtdCcpX1XIMQoOt+AW1cjmn+hnPasWqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4itNj4gR9wrXcpvEQIOhoczHzNBg1oJ9+XU3u6Kpp4=;
 b=ay3cqPpli3pKaODJN7jxNOyzB33CS7MDnuEKZfjYuysvPHCyKb1oQZ3G3G4OpBeJTMZBNqDcrA1SIP0R8HzktReHn7CLxe8ZW+560hXVml6kdePqddelT6aWb0oSG1MJrcjTy917FhX4vN+Oi2Q3oZY06PSENXvsCmuAfz79OrI=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2916.namprd10.prod.outlook.com (2603:10b6:208:77::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 11:54:04 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 11:54:04 +0000
Message-ID: <c05f8796-5274-21c4-79b7-3bfd7e1d2580@oracle.com>
Date:   Thu, 16 Dec 2021 19:53:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] btrfs-progs: remove redundant fs uuid validation from
 make_btrf
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20211216100012.911835-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211216100012.911835-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0102.apcprd02.prod.outlook.com
 (2603:1096:4:92::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c53ef663-df49-4bca-9b51-08d9c08ac199
X-MS-TrafficTypeDiagnostic: BL0PR10MB2916:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2916A42E0E94B75689944BD1E5779@BL0PR10MB2916.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQdeO6fI/SdJkX5mXwsI2I1m8V/hBSBglUHiF6d3a5tBuv/p6kLb8J7wHVP++ys/U9XmJXQYduiJYkKp0aTcZxiNb7dFwf4Jl8FUfogPGY+ZbCE2KJRVUNyMleBNUHzixiSGxJ8mwgw1jl6MBuYPOQni5SucvIPN4OUeoXIe9J+wjCatzETGzAttZt0sOn260gJ0p3uHMWNk5faIxTGKJyU9MsDshj2v7dkwT7ZshFPzY5KGGlTmwNQ1KFxOW+gyq3MwHmIV+KOS+izJuQiPRr2+Rjw+ngQCQhvVDq15PxMXrL8Eej1qfQ5jzPLAIokmtzuyE364O0AXdyQPGNuVk0yCS610Pgh0pngerrQ4ksNQFdlblO1yd22Le84/i/z+t86Hn2MNwXzIpz9jAQw5+FL5vNqg4O0MKixfUy90Ye/dczKQBw1dUON8jajQg8hK3I30DBbp1ApoOfhuo0DVO3noRMd2mU2MUyp8YyCCoQ0Z6/t9WHysCSZogyrrsZd0cu84AIB/6a1oG7Zpf80nAJr9OvCHyE/405pKLbnnlMaOy1Mg0HfJr+Sbv6bOidtrrSODduSfd1VAV/M9dO178ieVYKgvI0ms568I1LVX0NTKnp3s3lZELplmfW/8p1k9/NLzhma1hB5o3sRJvlrjg7EBzDbMZ/1azLmi/ukVkv3vjXGKAQCF9XG1NqJGrO/B/tCHMg1gXJ2TKJ3boMxjHKGtK3RvK0Rb4sZ4TsrwphtN6a2ArZgg6Azz0+Y+9JtDZZmiquypmVi89seTTSINTxIN0fca79EQbV6qUnPpmGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66946007)(186003)(44832011)(2616005)(316002)(8676002)(31696002)(2906002)(6486002)(31686004)(38100700002)(6512007)(53546011)(6506007)(6666004)(508600001)(5660300002)(66476007)(26005)(66556008)(86362001)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZGVW5oWktrcFI1Rk1nWkpLRTdjcEdKZll4RzFWTWhFVzN4R3YybmtmTVBW?=
 =?utf-8?B?MlM5OTRad25FWWpxZHFhbWM3WkRPZGdZYlpMc1UyRlROQ2lvcU9ZZ25sWjM3?=
 =?utf-8?B?cHBvaXJYb0JtRnBrOUF5VDhKUSs0SzdWbGpIaGY0c2NrUTJRenhzNnJTZUgv?=
 =?utf-8?B?M3RJQ2NNRFhISW9rMHhBK0lCcTJFYWFtZlF4NkdwbW4rbmdqa1FBYjlTZlZY?=
 =?utf-8?B?REowRFZwNmhnV3R1T3ljTk5HSzUzbzhBdnJRb3RaWUFXa3BoZ2lWMUtSOE4r?=
 =?utf-8?B?UHUrT2xrNDIrRXVYditNbHNEM1pGcTM0MS9ETUFQRUwyQkR6K0hCRWMrWjE0?=
 =?utf-8?B?MXRuZDYzL0ZxNE02dmllYXhxQlhYVjZXRDFLaC9jNHlBcGg4Z2t2ck9LZlAy?=
 =?utf-8?B?ODY5SWR3VGp5ZUlqQkcvQVRtN3ROY1VZTFNERXlTTzV0VThNR3JkMmJaN0da?=
 =?utf-8?B?L2R6b0lHWldpTWdxd05QSE85TUZLVld6ZXR1NGxJc0VlRjZnT2p5cE4rSHFw?=
 =?utf-8?B?Y2JxN1hqU3RMOGFFcTlYZHB2bGNjRUdQWUNmSENpaE0yem1DR2c4UlowM2xP?=
 =?utf-8?B?MXVWSi9aZTB1b0Z4NXBud1RzSFdDWkRJQ2IrazNDdXFaVGlKZThCRjNXbmZ3?=
 =?utf-8?B?U0hsbWlJaG5Sd3FQUTdvVjZwelZVY25LWXozcTdsL2gwTFFjUFlmVXdGd3ZT?=
 =?utf-8?B?MUlhL0dBcndlVU0xWG5nbDFtUHJ6eFZzQng2U1d5OUhTVVQ2Qi9ieEhWNzZv?=
 =?utf-8?B?MUhBa05ERUpnZFlrK3VwdXRHeXZYUXBMZk9kR1doUFhUa2ZUWURWK2VTR0hl?=
 =?utf-8?B?enpVa29NMDNFV0ZDWXNnOWNoa2VydDR2a2s2eGcwWWkrcDBFdEZVeUd1Q1Zl?=
 =?utf-8?B?a0o4SVdVc2RUTTd6cGZqeithaHRMWkoxcDBLU2ZWQ1UzbHhRVTF1SkRaSXhD?=
 =?utf-8?B?ZG1vRGpwNDJiRlJZTWpaamJkajloS0FrRjZ0SEFVbEx3SW5YdlF5eDMvd0dn?=
 =?utf-8?B?M0lxdVZRK2g4aktZYTJSZEkvV3QvNXhLVUtORnJLaFFpKzFvSUxWN3VPRlly?=
 =?utf-8?B?bmVjSFlVcXd4V2RzREpPZUdjT1lqc0xJNDZBMUlGN0J1d1UrcjRaZlg4cXBI?=
 =?utf-8?B?bGxpR28xWk9YY3BpZ3lOWHNiZGllNk1NK3MwR2JrcnY0Wmk1dysydUV6bHRo?=
 =?utf-8?B?QmVpVzd1a0YrOVRmN08rSUtzUjV5VVc1cFFZSllwR2NCQS9jeXM2SG9pS0NK?=
 =?utf-8?B?RmxFWTVXRkZuTUpXb3ZkeTFNTm9tSFNxbTBKdjRZUTNUeWFaaUY3TXAyaDlu?=
 =?utf-8?B?eU1LS3djY2VZd3VFbGdEb0tNUVpNYWZ0TEJYeGlTbW5kTjEzK0lzTmJySlAx?=
 =?utf-8?B?dkRvRE92eGo1aVh2c3lJYUVBN0pVTWg3NjMrMmllUXlVZHBhM05GUE50dVJ3?=
 =?utf-8?B?K0V6a2RGcFg1SHo3RTljeU8wUUdEY0VqOEREbEZZYWEvZmVxVVlTTXB0amJM?=
 =?utf-8?B?d01pR2w3dkt3YzA3WUIrOC92UVBYRVdUZnN0b0lmd2FZQ1ZmVlY3YW83amh2?=
 =?utf-8?B?c1ZjcWFqUHlPRko0RDVSMzl0cnh0UG1mVk9DUDd0aDFsM25PaHZDK1dVSFBD?=
 =?utf-8?B?bzdmeEYzR3dqTVNoQ3NMdkRqMkdhQ2h2L25YbGhJSi9OdWRtSnE5MDFuWlZH?=
 =?utf-8?B?Rmk1MkxQVXR1MnVNem5sQTc5RmdaM2svRUg4YkovWUZNNkpzT3VuTGJEREdC?=
 =?utf-8?B?VHM0N3Mrem5RYzVUVU43RVFYODBGRXBTaVlwZXJ2WllWZlB3bmtvMjR2TFpi?=
 =?utf-8?B?c1JySk5RTlM2NUszTk1mT3pGZGhwMHpHb1pOeGcwV3FVV0hubk92OERxbFly?=
 =?utf-8?B?dy81M1FOeGd3WTAvRTRpdlRnRDk4Q3BFUk1JOERlVHZGQlhXd3UrWjdvUDlN?=
 =?utf-8?B?R2xiVURaTEZkS3ZRQ2pGZzEwR0pNK0pqL3Q4MmE2QjZFOWVYWm11VVRMMjdk?=
 =?utf-8?B?RlpvZjNZOU5vRFZJWWl1S0g5ZTZBaHdhZnpLTkoyazQzT29KMG9UVHYwY3Q5?=
 =?utf-8?B?dndBTmpVSUsrTUMrYS9GN0p2YjFYSEFMb0wxUVltWnN2ekxCQ1R4UlNGaTBz?=
 =?utf-8?B?ZlBiNDR6OWMwUEYvTXRVMU5tL1hTaGFUZmFFdTJHNTlabjVhZVRrRlo0enF1?=
 =?utf-8?Q?F/5RTCTSvrdQ5IeFnFGY1cY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53ef663-df49-4bca-9b51-08d9c08ac199
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 11:54:04.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVIS+NsqnqMNuLFe1xSFJ044oocJNEVuneHSLdxnNJz3fjtQ2TAGLQl3QnyIEiuqbNYjnS8nY1a4HdXteK8iuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2916
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112160067
X-Proofpoint-ORIG-GUID: tc_6u6dsS6BoTgQTPfjq-xBPx8_jbcon
X-Proofpoint-GUID: tc_6u6dsS6BoTgQTPfjq-xBPx8_jbcon
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/12/2021 18:00, Nikolay Borisov wrote:
> cfg->fs_uuid is either 0 or set to the value of the -U parameter
> passed to mkfs.btrfs. However the value of the latter is already being
> validated in the main mkfs function. Just remove the duplicated checks
> in make_btrfs as they effectively can never be executed.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

--Anand

> ---
>   mkfs/common.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/mkfs/common.c b/mkfs/common.c
> index fec23e64b2b2..72e84bc01712 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -260,18 +260,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>   	memset(&super, 0, sizeof(super));
> 
>   	num_bytes = (cfg->num_bytes / cfg->sectorsize) * cfg->sectorsize;
> -	if (*cfg->fs_uuid) {
> -		if (uuid_parse(cfg->fs_uuid, super.fsid) != 0) {
> -			error("cannot not parse UUID: %s", cfg->fs_uuid);
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		if (!test_uuid_unique(cfg->fs_uuid)) {
> -			error("non-unique UUID: %s", cfg->fs_uuid);
> -			ret = -EBUSY;
> -			goto out;
> -		}
> -	} else {
> +	if (!*cfg->fs_uuid) {
>   		uuid_generate(super.fsid);
>   		uuid_unparse(super.fsid, cfg->fs_uuid);
>   	}
> --
> 2.17.1
> 

