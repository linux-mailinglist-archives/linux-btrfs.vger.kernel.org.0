Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10602FE7A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 11:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbhAUKbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 05:31:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58654 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbhAUKa4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 05:30:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LATahr142145;
        Thu, 21 Jan 2021 10:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vIQobOb3UaW/qBag4QDVoMDAgorTXx9eI0IlKyt+jxA=;
 b=NN9hQ6uZWJg4BtLvEzTy8WT/HOrAwcsRlRxEol9I6JX3GQt2+RQ+F9JR5+k8J4WwNTXT
 6A3X0hKnSgSEUXVNvs22N5PsEaXc5Y343YT5OfkoA6d9oYovyDGPRg6CUqPQzK6c9moa
 KwqVSUrMvNhmllt7FEZIZurCem0qwaIJIvyb1T6zKqZcS4vECdzGhL63Ps7Ah1BI9UC6
 7RL7Sybe4+CU/4UujzJ3SVBmYJPuOVqVg+lpvPD9GkTGYN0iq/OnzUPQDiuuyg+TvBMz
 ia789C7ZqSpkxcSTggEJ3rlwG5BDDHd3w66aHb/cN1h6UBtl9wdLnzxwnHZs1LIbioPm ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3668qaep89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 10:29:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LAPvjF008412;
        Thu, 21 Jan 2021 10:29:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 3668rffetd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 10:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjhxnmAfuaLdisaXieGU+ywYFld4O8/QFxZ2Yfs3oxTb/0Q3FpOn9bsBfytZA6/AtK4iYk8AuObdsbAK9Yqw64CTRE14Z1qynIjH7aKn5/NQ1+YXGLzurlysCpmarMEObNdv0Lp/1W4QYtuJwkBbgLu+HpYSgxePPQav4OpeLR8V/qe1s09SinUKmfWjh/Hj+1kK3efG8luxfCpTAOh0RrpVTuWRwjWSkaqIW2HeggFfWyaq2nL6nvl4cSZhb/SY9DmvrFSnFdf/lFnT1qEwhbNW4DTUDqlmqKVPwf2iZG4yQSr/MyV88GmPWcsVCONGKN2gnITOpRcRxLVqqjDMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIQobOb3UaW/qBag4QDVoMDAgorTXx9eI0IlKyt+jxA=;
 b=Cut/N/p7+LmelZw1uEohJVCGoWUvuE/altennOAcBvQPpQH3j82aiYyS9yAJbqzEmJ9kO1aZ5BOUIIkuAbasKLBMpWtKH+Y7EcDxlEozMxprg0fxcN86tTc+vnwvnNIdi87l/Fc5F+tk1et6HAqZdQOE229ryhia8YJR3RPyd6nYDUYhY5ojSJC1Kz8bfevNsMSvW9/ESHcVU2NEzveCLbu/9TaW8+tlF42pkIHcMKV1dLGjPNmJGHSyaCrne6Skh+OuKiTYPhkQyNoEdvglB09CdJCQvUfKWsujpo1HGivOSJfTyYOi5PRYf24obXyZLit+vWWZdqLpbhVTsVK/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIQobOb3UaW/qBag4QDVoMDAgorTXx9eI0IlKyt+jxA=;
 b=AXeaLh5w1BRgeqSTrKf24HZJ84az0WcJTUjG7vqESjLp1ZvbhYJKUIxLK6S/CHfDIEpV2UufaOTiAr1wO+g1OKXLl2VupVPBAR6PbmsU439SMud2bOmj1hlxOvGt+zFn8i2i9Okmcu8oLr+evBkMoc/LicechB9a0O7L3KWvYdQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN6PR10MB1425.namprd10.prod.outlook.com (2603:10b6:404:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 10:29:56 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3784.012; Thu, 21 Jan 2021
 10:29:56 +0000
Subject: Re: [PATCH] btrfs: remove redundant NULL check
To:     Yang Li <abaci-bugfix@linux.alibaba.com>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1611217187-50142-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <583d9738-dcde-6e7f-d995-5d8b70ce96c1@oracle.com>
Date:   Thu, 21 Jan 2021 18:29:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <1611217187-50142-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:3:2::22) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR0302CA0012.apcprd03.prod.outlook.com (2603:1096:3:2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6 via Frontend Transport; Thu, 21 Jan 2021 10:29:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ac8f8bf-69a3-486a-ddbe-08d8bdf77f27
X-MS-TrafficTypeDiagnostic: BN6PR10MB1425:
X-Microsoft-Antispam-PRVS: <BN6PR10MB1425401008AD2A1F236A9939E5A10@BN6PR10MB1425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsUILRw/w2j1p9hKeXQNtuhHNqC9A+P+qDTmBtaHM3uI1YTrcvWo+5oMwldGp8yE9jcNW/R3zC1RFYot1Xo8mSKaF5iEbpXmukbMb6/vyOUZRwovtegGc7obBXCBZ1JHwPe97ujMcv2i2YbCXs861nr/MUwSaTTzw2I+5mgsAhfYxllnbAj4b9FRVkT/mXV3mSsgGh/G4xE/jt0uoKVvlFtWllUMIx6BWAN768GjXkXcMOJ6xEM88EQkPX9I649BYsdEFVdHFjSe5riVz/4KRUSTaKccqKD4zEb13TI+yTKKWO8+5PKIQxYVN5Hpo5yCzXMsZHTXLyDsQix2SUZULe9LmfUyY/tabkX9ytEkbrmOfyDEbD9ePwXdcqYw2KotZnIO1dFY4k0eaL+S50IqaJtdjHYeSSeLxT+QErosAgAGqiAmlqKiQcOhbjOFG0wuL1Xia6uZPuygWiCQaepOyaB1DsxkjdqOlpPDACA7aPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(39860400002)(136003)(8936002)(31686004)(956004)(86362001)(26005)(4744005)(2906002)(2616005)(5660300002)(36756003)(8676002)(316002)(6486002)(6666004)(186003)(31696002)(16576012)(16526019)(66946007)(44832011)(66556008)(4326008)(83380400001)(508600001)(53546011)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?amRmc3YzTkZQRUxEOHozcGttTVFIdHFVRlk4MHorSW14VzN1YUwyUG1WZ3Mx?=
 =?utf-8?B?YXlJdUlVZTJPUi92enRScldwMWljdHF5RTF1Z3BXRlg4Vlhxemo2NEpUNzRy?=
 =?utf-8?B?Y1dVczRuNm0rTTZhOVhYSlNDaVdEK2tINm9sQTU2R1R4RzR1UkRYYi8xN3Mx?=
 =?utf-8?B?QlhxVnRiMjZvcFo4TzZVakdRa0lFcjBndWt4ZUloempwRzBoczAvQktQN3dB?=
 =?utf-8?B?cnUvQlJZQ2tYTTFyZVl6RkcrMjJFdlJBQmxFVDliZ1BtaG5za1VJOHB6Tjda?=
 =?utf-8?B?L2JmVWFBZzdOOEtkellSTW5NMldJQ0FFZldRdVNUeHlsM2NrZEFRR29pbWtU?=
 =?utf-8?B?c2g1ZTRzN0Q4Qit1MkQyb3Jnd3g0VUxDa0RLYlprSG9VWlBEWkVzOGczY2U3?=
 =?utf-8?B?VndYMkhxQkFzaDR4cWllMERUbnM1MDR5bi9Vb2tjVzNZL25ZYkxmRFJUMDNw?=
 =?utf-8?B?ZW9RcW11c2JPdUw0Rng4c2pMZ0llem9UK3RuZUJ4S3A4UU5sUENKQ1d3bXU5?=
 =?utf-8?B?VGdSdndWRWVVQ2JiVk5XWkhNTG9kVGgrRTMzcTQ3dEdmdHM5MFVvRTVLaGY1?=
 =?utf-8?B?QVhsdGFEMkdhdjBZa2haa083MUUvalBnTS9iLzV4cS9Qb1NReEtsSWs5cjZU?=
 =?utf-8?B?NWRTWnhxcjFjdDk0bHhSTGRqaEthMDY5L1ZFczcxY0hnOXNqUDREMVh2STE1?=
 =?utf-8?B?NEtUbm5FNjV0ZHg3NU5naC9rS0NVT2pvUUpWSklUTlYwNjlOM3gwUzRxVlN0?=
 =?utf-8?B?Zm9HTm52N3BzaktneGF5M0ZUbU04REpjcjRFK1d0MWNsclo2OWhvVlB5azla?=
 =?utf-8?B?MEpsdUtZbUE3NjU5OW9kWDYvdGpoUUE2R2NUYWx1eGVGQ3Y5MHp3em9jNkh1?=
 =?utf-8?B?YzNUSDg3L3doQjh4cEtRNHhpeGdYN2VqNnNyNXdsbGxSV2l0UlVMd1pBdUJS?=
 =?utf-8?B?TzFjODd2SzJSclZrLzBUOWpxQlcwQVk3eTVSVUJoVjhxRVVoZDVRVk5TaW1k?=
 =?utf-8?B?dDV1dis2Rmx6WVFLcE4zbDZ1QzZLdEJOR09pMWx2ejFpdVFNY2lTL3VEbmNh?=
 =?utf-8?B?YTN1SERDcVNyaTdCWVhqUlJ1WjErVHNpYWhvWTZaMVIwZ2l1RlhkOE1tTFIr?=
 =?utf-8?B?YVRkLzlXSTBKM0l4QVZENkI0cjd6TmkxeDZ2UGJSc2YycjFvUmJFdEhXTUJU?=
 =?utf-8?B?WmxQUXM3OHFaQXEweUduM2J3ZmRMY083S2ozczN0U21BcVF3aHhzOWl1cklo?=
 =?utf-8?B?a1JLVVR2UXhtbFJ1UGJWeEtIR01lOTBmbWF5RTRsb0c5d2duY1Z4ZWwwZG1k?=
 =?utf-8?Q?5EQinnAl1ej9BSvggB2/JyXtEjCCa0cHlv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac8f8bf-69a3-486a-ddbe-08d8bdf77f27
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 10:29:56.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg33Cu+2fD3cYD/l4kXefalFIeC3fJiYfGrD/nAXgibkvF2nPZ8DibVwOl5spEndfzKlzA5XivXXxTC/Pa5ZUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1425
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210055
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/1/21 4:19 pm, Yang Li wrote:
> Fix below warnings reported by coccicheck:
> ./fs/btrfs/raid56.c:237:2-8: WARNING: NULL check before some freeing
> functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
> ---
>   fs/btrfs/raid56.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 93fbf87..5394641 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -233,8 +233,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
>   	}
>   
>   	x = cmpxchg(&info->stripe_hash_table, NULL, table);
> -	if (x)
> -		kvfree(x);
> +	kvfree(x);



  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


>   	return 0;
>   }
>   
> 

