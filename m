Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C62939180E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhEZM4U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 08:56:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53294 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhEZM4N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 08:56:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QCnb5Y014814;
        Wed, 26 May 2021 12:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KWmC1j5PKPAypR/JxlXJ1fkoDknmiH1BYbMSMhkA63U=;
 b=hIHggBHIUAhAVIitvUOQcIpza77U8Unlv7pDMuaHCR7UQHBeXhhZ9sbLS2NjqS8lrZfH
 8dU2VIoi3vFHEiy2gvApmw22EXbYBzMTIMFkNYHuRcE8z0uXnCHJcRaoGhZHWaPtFR8w
 Gskw0Eb55SGaOtqFKlSYZMjiFOoLFoydwW/VdLOn+D9s59NCfpEDiwR3CNGUpN1u9Cqc
 PeMJak0idgk77IIDvWJ4HNLylw0B46cSBQdumNOgwfE2Gm89a90udiUfYAi+h2rvsbfu
 I0+m+l4eON1nvsRLB3C2JfhSqQgLtb4xlDrOygnL9fdVS7m0IdrhdHLtUPJirZRyy++8 qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 38q3q90bnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 12:54:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QCo6ve142139;
        Wed, 26 May 2021 12:54:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 38pr0cpb8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 12:54:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBNL9NGV/PvbBkcm/JNEVmFTu/QK5KymGuNqUP4J1Vao5AJIqCarSU4fTwaa15O3QlaGof1Sb7QnmIt4tnjRY1GHC2omkUaNO+R6P4GakWEO0+6lE5v3yQ+YK8lW7GZ/3Yv5gm5x52aIlMv68F3YEVk0wMMk+EPP7E0oFEANC/NWl+bsC5Q/ioOXmDz7ldBIvdsoAB9d3Vst8J1MRoqZ62axtvn/dX6mO4SLQC/m1XquXPQZxMxa2It1e1Spq+6DaDME+n33qK/bcIDm1rgrvwi5NrE4Hy0OhraYjYQwEQAXUK/SaAbWf8hyBeEslXb1klZ+QKS7bV2Am3uPGgVn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWmC1j5PKPAypR/JxlXJ1fkoDknmiH1BYbMSMhkA63U=;
 b=X6EanFhPbg3z/+d8LIJ3D9DArdAex+eBXunitZIkU9UNFRV6sIXFRgPkMtZsLN+mr8EHZs/jU9d+KhO2DHZZHw/GXEZTIlujVHmoJcTsh0k1ytcQKbVnXl8YZejY/c4l6SxtTLWaqmMIMWakv91RUa0uiiATNuBTFlGHjl6i64TwhACIlw1WgnpOdDk2q6Vr1ASWda2pDroROn51L7S4EwCrPgxuMyHAcV+ZxPE6Y9eqxFJ5/yrD28K5KzHJjrPno8c0+qA141UBRyrWH7csDlyDVdwwmV+ijbY0Cnfh38a5sw+QBDSOwZeFM70v7k8pzatWTxVzagfvEyZm6alySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWmC1j5PKPAypR/JxlXJ1fkoDknmiH1BYbMSMhkA63U=;
 b=tcpZCCwM7fFOWY+GmsaoT7EjDJoJtU/JyF1RHU59Kcd79sydSjIvw+sKFMZZE+vLsoTTV714ScpqMrZG9CeR+1A7+I4R4k42lj6vBPfimCaK4lMp6FM3f6uQFo8ogZ8uGeRT72CNAyd+tx1SxERtXte4/XkIPG0NDLwSHAxWTSo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5314.namprd10.prod.outlook.com (2603:10b6:208:325::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 12:54:35 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%8]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 12:54:35 +0000
Subject: Re: [PATCH 7/9] btrfs: remove extra sb::s_id from message in
 btrfs_validate_metadata_buffer
To:     David Sterba <dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
 <9728b5a77818ff0c6ab80f2fa1de72c9f5c2ab32.1621961965.git.dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6af7bb1e-6942-1f30-8e89-2221fb4b0cb0@oracle.com>
Date:   Wed, 26 May 2021 20:54:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <9728b5a77818ff0c6ab80f2fa1de72c9f5c2ab32.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:c97e:3e12:797:83c8]
X-ClientProxiedBy: SG2PR06CA0136.apcprd06.prod.outlook.com
 (2603:1096:1:1f::14) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:c97e:3e12:797:83c8] (2406:3003:2006:2288:c97e:3e12:797:83c8) by SG2PR06CA0136.apcprd06.prod.outlook.com (2603:1096:1:1f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 12:54:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 350407b2-fc0c-4bc9-06bd-08d9204569db
X-MS-TrafficTypeDiagnostic: BLAPR10MB5314:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5314E891EEC65712D5F637D2E5249@BLAPR10MB5314.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:104;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtNoj9vnEuFeIFtYMMlx966ftPNZ/eWwCfOkDtv95EubtmJ0IrOEj4qa4VDA5IM/qsVC7CeHnvQNq9o5faLYT/2pnY8vNqOYEGMlHa/8vzOOr5nrcN4JN1Dss9K0TNEKXPjS2K9W3oD/5JhaKHMwALWDc6k94wSez7c7KT1havRx8jIM2TgnueXFDZDhHOWWmb4R8Vb7SAFtrgrHlhJVPEjOex06oEkyXcDfK4oyvyQkcOga4/2afudPLCx7K7EIq5RhBFxoIOvpRa4T9Bc0fL+cq7pkz3yCz/5IGUjq4EK6Ofhs0BPtGBaN7vmocb44C/a3NXjosDxaQxuSkm95wYaU5Fsp0u8aU733Co1rSjGmYKRedmNuzfxTxJCypf3Lb4WdvCwDp7JPGjUXdh4TnAvZt4j1e1nmlswkwtJjlTK11KPhollsDG8E0u6iHxwK2Ne+z756MQEz3bdf8SdtvLVt05X9ClVIbXNbpfU6fKuR4F/r94aK9dq0b+Nchim91kYEKKUxd9VDrg7HisFqOKp6ypnNxS4ZSjogYJcESte2Gr08rGtMbNyuFOUXDA923RDJBDbKJJcgu/3JbSYVKW5czk7tzi2eP8Z7SCOmk5OgFsIq+E/cUJMjNcJL8g/xQWUMkZzF6QJMpoqyXaCgdLLvcHIrA8sSpvMn/3NcT1SbACcJEGh2N81LO6Tp84rN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(36756003)(31696002)(4744005)(66556008)(66476007)(4326008)(5660300002)(6916009)(316002)(186003)(38100700002)(478600001)(86362001)(44832011)(31686004)(2616005)(53546011)(83380400001)(15650500001)(6486002)(66946007)(16526019)(6666004)(2906002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VWRaa0RIaFBNU1ZqR1NueUoxOUVuekYzUTBlZ09VcDZHYS9YcnB4azRIM2xv?=
 =?utf-8?B?NTVsRFJmekI2K1pPNThuUm42N0VVWC9uMWs5QWFNLzArbytIMjFnanduZmI5?=
 =?utf-8?B?MjhGbWZ5a3l4QWp5K3MyRzNwS1RadzNzelRSNklEelY4QlhtVGZ5VFRYYWJE?=
 =?utf-8?B?em1iaW1KM3RjZmVraklhWjlMRWQyeFBoVnIwYnJTZWJJdFJOSXVzaGdtU3dx?=
 =?utf-8?B?dkd6aWI1OFFYRitqWmxrUHRFS0pKN2xXbnViSkRQL3ExUTVGcUxIZy9rOVYw?=
 =?utf-8?B?emczQlZ5T2U0ODZzbm52eGl0STJoQW5YL0JpWDlTWmRFMzJCQnZSMG1Hb2cv?=
 =?utf-8?B?cjhmNzhNMzdvSDV0V3VvMitUWWRNVVlycy9aSjFSWkNlK01xZzRWVldobW1l?=
 =?utf-8?B?a1pnR2IvandqdXRwWml3Zm9iSnZ1Qk4rblVsQ2NOakRmQWVsZG5CeUNxU29a?=
 =?utf-8?B?NTZFclpmYjJ5aEJ6bStCZjYzMlNBbjVMWGE2QjU2aGFVK1g2NlRBOUtJbVFN?=
 =?utf-8?B?dzgzSkVnVmV6ZkNkc0JmMUxSY2dYbFpzSFBNK3ozOXhHaW5wMU1EQzc0Yzdp?=
 =?utf-8?B?d1JTdUtHZ1VlMGxSV21mSDBwNzIvRmk0N1FrR1BhK1Q3dWF6Q3BZOGVOSTBO?=
 =?utf-8?B?ZnJTSHdVd0ZCbmJGY1FwQzZxSk10eTd5elk5V1dBZjFlY01UWllhcWRpd2FS?=
 =?utf-8?B?WGtoRkdmZTh4ZDFaOE9yeHBEUDA2RStNTVVzNE1DTFk3RHpKR1BkakRrMG1k?=
 =?utf-8?B?VjRmTkgvUTVoMjlzT3ZpbTJsZnlpQTRnVFQzYWRueDJsZ3Q5WExDWE8xU0hM?=
 =?utf-8?B?UG9FRjZvTVVNNTE0bktnRThjYXFnQkNMTDA0K1pPK2g4akJKaG5RTFhtQ0RS?=
 =?utf-8?B?dm5NS3J1NGg3djgxdzN1dHZ3QWRJQkVHb3g4ZTIva29RVkx2MXVTVE9vTEJR?=
 =?utf-8?B?NU03aUlwcVpianpwUjZkYmJBYm1ldmJQdWlYVnJoR0pPZ0s5aGRkallmWXBV?=
 =?utf-8?B?SnlMRytBS09hV2laT1hXdGxOUVVwM1pWdzVqc3Z4eUdkZ285bmduN3R2bnRi?=
 =?utf-8?B?d3hhMUhSalp6dG02aGdNQmR2SmZuYjFQOEp0c3l2WUQ4NkxOZThaWkRwd254?=
 =?utf-8?B?U0VZYTVtMG5UNFYrbkJzRHVZOUJYOUtFcFEyUEwwZml2OVMvMS9sa29tMGNR?=
 =?utf-8?B?TTJEdkN3R3hPWWdiYnJnSi8wdlZEK0MvTGkyZ2JhbVlZNjRTa05nakZSYURX?=
 =?utf-8?B?NG5FQ1dodWF4VmhXbHBPemRhbXRqZEt6cG5UM3BLNmE4R0ZrWHZ1TXZJdDhT?=
 =?utf-8?B?ak5xc0J4ZFdaT3dhTThyTkdiMEpNaGptaXo4NDUzSmM3UFR6SXIvTFduNjIr?=
 =?utf-8?B?S2FjL01nUWdsVzhRaHZHYzZtVUZwemxqMTFEeFZkY3RDVU5scEswcC9YQTVE?=
 =?utf-8?B?aU5FT3pMUEhsTnJZNGxRRC8vSlMrbUF0UGx4b1lvWlZvd29rZU9uS01SeHVP?=
 =?utf-8?B?VXM0M25ncjFMKzZoRUtxQ1d4WjdqZjNCaE5IYmZxb3ZKdGQ3Q1BheURVa3hy?=
 =?utf-8?B?bUlIZVNidXd6VVc2SjczRDNWaUlFbUVZSWpCZVVwUGw1UHQzbHczYlloZG1h?=
 =?utf-8?B?Uk1aWmI1QkJmaUhYVXUyMkZIL2dEakY5MXlzUXhhR0Z1bHpVMlFjeTVUSEtT?=
 =?utf-8?B?a2pvZDhWL1Njd2VHOHRTUTJjM2diRzdFU2FBM3I1OFAvK0lCcjZwcWtCc2hO?=
 =?utf-8?B?WDVlUnR1U2tBY1BwMGppdTc4TU5kMHJndy9sb20xUTVVd0EzNDl4cmZkendN?=
 =?utf-8?B?UWZWRW5WRXoxempBWFVrMy8yRklDMkw1bFNmZnlPZVZmSnYyek1pbG4welV6?=
 =?utf-8?Q?wqn0pWfin7D88?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350407b2-fc0c-4bc9-06bd-08d9204569db
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 12:54:35.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N7CDBWdiDyj6sumWAESWE4JFcw3Zkx2zGb3JLTaTg1G6PjJGCCRb+djjxLGWGHVyBP0UnLaXLScZB0Z887hOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5314
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260087
X-Proofpoint-GUID: 9cwz4LiYtnHtHFpmJRej8tsMvuj5f4h8
X-Proofpoint-ORIG-GUID: 9cwz4LiYtnHtHFpmJRej8tsMvuj5f4h8
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260087
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/05/2021 01:08, David Sterba wrote:
> The s_id is already printed by message helpers.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Thanks.

> ---
>   fs/btrfs/disk-io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8c3db9076988..6dc137684899 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -614,8 +614,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
>   
>   		read_extent_buffer(eb, &val, 0, csum_size);
>   		btrfs_warn_rl(fs_info,
> -	"%s checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT " level %d",
> -			      fs_info->sb->s_id, eb->start,
> +	"checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT " level %d",
> +			      eb->start,
>   			      CSUM_FMT_VALUE(csum_size, val),
>   			      CSUM_FMT_VALUE(csum_size, result),
>   			      btrfs_header_level(eb));
> 

