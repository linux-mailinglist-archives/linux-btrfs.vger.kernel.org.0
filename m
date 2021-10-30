Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D82E4406A2
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhJ3BOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 21:14:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39074 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhJ3BOX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 21:14:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19U0KPfF014448;
        Sat, 30 Oct 2021 01:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZDhQ7Fmw5O2yrxb+WXC7/Mz/7c+klGo2/DoomGm7fAg=;
 b=DTuhrSJoivFf7Stlt7aWp1PRebq+QH/0b4ZvCHYwTapeqxqBGJ8LlSlb9m6uysqIWHQw
 Wn8svRNYGE7Y/FLAU5IMdqO2qnh9JQEMAYiSUGlB47fGtXY4o1zZ4IhRuZ4eCsXtbYUV
 596/9sbAGVd/AZjGz5uk/Yn0TKoJa0pqWfuWZFt+SyhTFumRmJY22Wqe7JO4y3TL79GL
 MZ3raNxdaFui+9anXU9BNJmoUCLUoQyEY89CSMqhIo6YykaIuz/V1T1fgFE3LWWjm9II
 dhu78ptbGAjpXAxI67wIDz6zb4XNOUyiFcC1ZyWgQobhmvOLP0FzVt1VOozU1nmn7p0i OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byedauk4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Oct 2021 01:11:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19U167WN158935;
        Sat, 30 Oct 2021 01:11:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3030.oracle.com with ESMTP id 3c0u5shwpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Oct 2021 01:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRkSBXrAcSL9XD6Hxuy8OZyf6ltjyhGIcMqFUBUvVK4JFDsgf2OMNuRDqrSrL73ojPiD/aY4llogoGQH7gjuM2ZDrKk01ZgoVzdE1VZihNKE+Hiu8j7G8E0wMxMX1dec8/1IYTyrx9EMcrc+d4yJ+WFA/uRGkuNmqpVDMBLCrooJe0rFA2LBLq6Y1Q646+dlJB91wP63nI3edWI414f7xC3HggtmlAzi0Ymja4p2mPCN9M5PIwnXnW9HDc9WkDgLYDqrcxc3jH5KP75VpFiAPmMu1ssvtvvxN81SXocRbCAysGGFwyCCaVVoQ/jgiW6mV1EuWttS4czsBV+tr0J3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDhQ7Fmw5O2yrxb+WXC7/Mz/7c+klGo2/DoomGm7fAg=;
 b=IPyVxCu5QEY+CgwDSTI8TDMDTdrvlR1TVD+5fzwSuU+C9qxZKq+OVY/GtqBPOwTBQEB7Ed1A6hNpqooaFPLiC1/rdH8He5XHe3EBu+dBxzw/IkbKcronjKQgrizD85yZ0XgLYO5Nm+QxwfYNwREB26+6tMuEeuApMA6zUuKTkYkXExC4oCjPeektPN23fnd/Ks3lZhcUwSrIucRCKLPCbvAQ0uQLQYO0EXHRLi1m9pZUY7hdgIEL+E5D+VW/PQiAzoK5o+C6oda4GbbDaO159iFUrgLBi6uL8btWPAJtIWBPZCRhJCS4Rx0JuMztqk68i9gytDqrvp/QkldcACiNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDhQ7Fmw5O2yrxb+WXC7/Mz/7c+klGo2/DoomGm7fAg=;
 b=dMIbBeENGhDsN2JwpeoP5pkVZHzhx0Phy/Ww510KB/BAilSgm/ycJWYOE8NHHKkVd0hva7UfVSZax1bJlEKtMssTuVXSRhYvwcx29zxSgZoVHSrF6zyXfQjZ+FfhcPoAE5COs9udMEjvPBLZhRQiCPZy+6b0VnEJIcZ2P0hqx58=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3968.namprd10.prod.outlook.com (2603:10b6:208:1ba::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Sat, 30 Oct
 2021 01:11:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4649.015; Sat, 30 Oct 2021
 01:11:44 +0000
Message-ID: <264fc430-10d1-96be-f29d-2571bca0b047@oracle.com>
Date:   Sat, 30 Oct 2021 09:11:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] btrfs: send: prepare for v2 protocol
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com, nborisov@suse.com
References: <20211022145336.29711-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211022145336.29711-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR02CA0017.apcprd02.prod.outlook.com (2603:1096:4:194::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Sat, 30 Oct 2021 01:11:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7ce401e-60ab-46ce-fb31-08d99b423cd3
X-MS-TrafficTypeDiagnostic: MN2PR10MB3968:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39684B6F4125B6FA6E8973C6E5889@MN2PR10MB3968.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUWrBIfwygWF1EEgUcth+gyTabL5LO1e97XXcfjvYsxIgdgsOBOiUybsEW49nMMc+XQ78UARd8BgwwIb3iMoBmcole3lZv7Iwnz6ezpnUb9VLe5ceJ9Wi5twrbkIh2YuGjqxWe916EMNHnhvmXyZ2PX8rm6TW4zY2RoFhnU1z1AjqkguPPdUrvSfyKwnw1n93KhiGLAu0S7UPXLbts0J32ydNbwt0swpHebn0xOTUgUslpgdlOOMe4hVmq8/rTbg0qHpUMjjFy03wJ88qVfxfIEUR2o+s/Vn8+IhzkUU+USinhDQigA3GVhNI4v0HhnY0OpLr9AC2PlcIEV/OpkKlaxLdTxLxCY+RSFc/RujOUvraQ0u5W6uzGJz0dkSjRijbvdN/GFSClIlTe+X9W3iPmoScgI74CZcOplZo90OwYW5OAowxoLAr5Ys6NMlYW0YVGA4hs5xTMZgCXQAeWgsfqRITYJOoiVaBO+s9BNnM1LJ858XHOJeV8v07pgzvbcduy5WEIeL1SGnTX8Jm4217Mb3i4RdNw083LDiSldItpwDnTtU2tMxp0hdZ2YMeyuaWRywwQVEJVTy7KN3WZG2dBD1aWflUqjUmrzj/C63u4h36ig0oxfi5Q8o89aKPZI4G6KhUPspupR0YdMO1J3suyPrtvJ09CixW89Mr9tlFeXnNeX2xjMMNDgpYI1HhXhaup8nnRu3YeTIp8jUWpnkjXbOkxL4ixYVA0m14reeqNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(2906002)(44832011)(31686004)(31696002)(4326008)(5660300002)(36756003)(86362001)(66556008)(508600001)(16576012)(316002)(8676002)(66476007)(66946007)(6486002)(956004)(2616005)(26005)(38100700002)(8936002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9QKzhuSWNNVlhvOGNSbHBVN29sNWFSdnpTVklHUFdQMStOaHQrRnk5VnFL?=
 =?utf-8?B?bEprVVJRdzZEdFI1SVMrTDRkdnFEblFVRzhoRjd2MGc1UW1JWFV5eldWOFd4?=
 =?utf-8?B?Y2p2VGd2UlcwQnh4OGl2dWxBMGpLWjdNMHlCRXd3eTRvSEtNbnJocytJZlBo?=
 =?utf-8?B?cUhiaVVLYXJoTjBnR1pIencyZGpuYWdtTTF6MmVLYnphTWNXSWh3VGd6d01J?=
 =?utf-8?B?WCtzVFR1NTdQaG1oTFNlSzZhSzJ3ZWlUVDVoczFOYW5nSDM1ZlQvQVNsY240?=
 =?utf-8?B?Z3gyZGlic2hTZmtMaXVaVTQ0WUxNT2lDVFVpU05qMHYzZFNYNy8ranVQTG9U?=
 =?utf-8?B?bjM5NnRMODJuUythdzIvd0JJRFFDc0Raa0R6eldaU0RPMEowSDhnZTR0aCta?=
 =?utf-8?B?REZtYjFCY0xSK2ZaekVQQWNybUlZbzJKaTlpS2djUG9HTHRnRGd4c1ZjYUZ6?=
 =?utf-8?B?VCsrZE9IYVp1Qm5lajlqZGFBeHV3dkdObzN1bFYvTTBSSHFxMXlEa2VJdytn?=
 =?utf-8?B?ZTJzbmtjMytkTzQ1bkNBK1VIODNoR1RhRUtrcHNBVWlZS05lTytjVDhXdkRW?=
 =?utf-8?B?Z1FJR01JT2hCZXFJRGpJNDRWNlQyT1EzVENTa1diRnFxV3FyUTlZcWhYV3RW?=
 =?utf-8?B?UnZWZWpIWm1DcmxwWVU1U21zRlRuZ0I0NnZsditJd3ZIWm1jMWtJbncwSTla?=
 =?utf-8?B?czdCL3VoZ3Zzc0hiVUVYMHdpK1hDMms1QWJEZ1BjRTdQeXc3TC8wUENQaEhK?=
 =?utf-8?B?TlgyUUtpc1c4TmtTSlMvK0xPYmlQRloyODFjT3E3Qm5ibXhiLzFPdmViMzFt?=
 =?utf-8?B?cWt0UktTbnNHcHRvMEFZK1VjdVlXb0hsbzd4UCsyWENwRFBJR1d2SmFJd2hu?=
 =?utf-8?B?TDAwQ2hrQ3VLTFA0Q2dUZzYveG1rZExaYnZZaHY1dU5ST0dtbjdOaTR2akNa?=
 =?utf-8?B?RGZGTTBPdWF5N1FNREJqeUk0ZHJpMndwaGU1dnVwTldEeFBzSjZ4RWFMZzY4?=
 =?utf-8?B?cDd5a2hPVUhSMW5ZcTlyek5WVUNRVEh0cnpvL2dNNE5WbjJYazV4R3VqeEly?=
 =?utf-8?B?VENUbEVsOVRXQ2FrS0k1bVZTUFI0c2s1UTNvZG9hQWdRWS8yMkU1YjYrMy9w?=
 =?utf-8?B?QVlsYjNnSlo1dll2TUZuYnBCaGx3dDh2ZE40Wi91VWE0TVhUb1RNdGZJT0xp?=
 =?utf-8?B?OHFuMEtBclBvTDlEcytJNjd4RmRTbXpWRFVBWk9CZUhiOHprOVBQakZHdGZ6?=
 =?utf-8?B?bW5MVU8xQXRYUVZoY3BwdFc4cVdUS01ZWnlHSm1JdEdnbkR1aXNhSHZxU2dZ?=
 =?utf-8?B?azBMTEZVcUpTcDlLM2QrSENxZnI5aVpyZkNzQmtqOUpraEl5VStzcXA5dTdZ?=
 =?utf-8?B?bXdDejZ1c0hITVF4amZKOVZ4TWRWdFhqOGRORUhiMGpseEtOb1lpNndLZFU2?=
 =?utf-8?B?Mk1XVmJ2NmNFOE5UbTBYZUMrZ3FrWVRwcmZ6V2Rpcmt3dmVDRktRVERVS1E1?=
 =?utf-8?B?UVlJSTU0cWlBVmtQanY2Yk5ycFFDbXFXQ0xVSS9XQ1IzZk5LaFNKeWRkbjhP?=
 =?utf-8?B?c3VZY1VFTGhWY0ZjdGRlRkxZOXljclYxWGgyejlDOHFLN3hkZ0ZqNGltMXZU?=
 =?utf-8?B?T28yQU5DY3RUNkVDeksyOHdKNFl0aEFiZ2t2YkZ5SG9ENURQU2E5VGFCMW5h?=
 =?utf-8?B?V3AxSHhpeE9VQ1R2ZCtwbmk0WUl4K20rdmpuSHNwbXpicWt2YWl4bE1PRHQ0?=
 =?utf-8?B?Tk90b0YwcVdZb055WFd4L2thaE54b1JpRW5ieHdha3hHeDBJV1pST2NqQ3V2?=
 =?utf-8?B?OVFZUVZrUHV6dm9mdXltY0tCVGtzWkdnaGxqYTYwLzJIZzhubmpaOTRYYlpH?=
 =?utf-8?B?MjBQYnlPUVNzR2c5djJUR0lpaWZHZ010YkNJYzgyY3VGei90REkvQjRJRjBD?=
 =?utf-8?B?aFBuTHlDOEg0YjZ2bklrdW8wbG1YWldiaEtOMGtSUGwvVkFrMWE0VFd4M2JB?=
 =?utf-8?B?ZWhrd1lTZ2tCQVBLeW5YTmZJQ1NDSHlYZXprZlNhSHdaYnJtd0JoZTFYa3lJ?=
 =?utf-8?B?WVl3N0c2eENPdUZQUjhieUdVQ0RBNE45a1ZncGkwSzNsbUJRNmdYQUk2c2lu?=
 =?utf-8?B?MjVQTGZUeVpldVBoR1hXYkhZOEl6c3l0bUd3Nm1aSUxob05wTlZQYUI5MHMy?=
 =?utf-8?Q?hE12gDcxHpSqXsgkx5/Tcyk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ce401e-60ab-46ce-fb31-08d99b423cd3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2021 01:11:44.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anbSv8sOVQv5wwDVCi5/lZkz5WTVIdG06Dy1SN2ZrIRsbfUYdZkUuOP4gvjbblAAd+Fen3KzfO3goiKSZPoe2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3968
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10152 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110300005
X-Proofpoint-ORIG-GUID: LDv5YMEntDApYqE9RwNy4rZTlLnJlLX9
X-Proofpoint-GUID: LDv5YMEntDApYqE9RwNy4rZTlLnJlLX9
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> @@ -312,6 +314,15 @@ static void inconsistent_snapshot_error(struct send_ctx *sctx,
>   		   sctx->parent_root->root_key.objectid : 0));
>   }
>   
> +static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)

  (Now I understand the use of this function).

  2nd arg can be-  enum btrfs_send_cmd cmd


> @@ -771,10 +771,16 @@ struct btrfs_ioctl_received_subvol_args {
>    */
>   #define BTRFS_SEND_FLAG_OMIT_END_CMD		0x4
>   
> +/*
> + * Read the protocol version in the structure
> + */
> +#define BTRFS_SEND_FLAG_VERSION			0x8
> +
>   #define BTRFS_SEND_FLAG_MASK \
>   	(BTRFS_SEND_FLAG_NO_FILE_DATA | \
>   	 BTRFS_SEND_FLAG_OMIT_STREAM_HEADER | \
> -	 BTRFS_SEND_FLAG_OMIT_END_CMD)
> +	 BTRFS_SEND_FLAG_OMIT_END_CMD | \
> +	 BTRFS_SEND_FLAG_VERSION)
>   


Kernel use BTRFS_SEND_FLAG_MASK like this:

long btrfs_ioctl_send()

<snip>

  if (arg->flags & ~BTRFS_SEND_FLAG_MASK) {
  ret = -EINVAL;
  goto out;
  }


So the newer btrfs-progs that sets BTRFS_SEND_FLAG_VERSION on an older 
kernel will fail.

So long we have had good backward compatibility of btrfs-progs with the 
older kernels, could we pls maintain that?

How about creating a new send IOCTL so that when the older kernel 
returns -ENOTTY and the newer-progs can fail back to the older send ioctl.

That is similar to what we did with

BTRFS_IOC_SNAP_CREATE_V2:
BTRFS_IOC_SUBVOL_CREATE_V2:
BTRFS_IOC_RM_DEV_V2:
BTRFS_IOC_TREE_SEARCH_V2:
BTRFS_IOC_LOGICAL_INO_V2:
BTRFS_IOC_BALANCE_V2:


Thanks, Anand


