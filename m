Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C423A3ACD
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 06:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhFKEVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 00:21:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35202 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhFKEVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 00:21:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B4FE3V112368;
        Fri, 11 Jun 2021 04:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HTmR8iWRdiLVfg5Kg/DbDnCyUN6OyaktdDfnoFAfkA4=;
 b=KJZeDisEYJ1+ewy7gKdKeLVlPgmbhcci0x+j0JmdxFJ+jW3IV7h3coNeyOrP9Di2g5is
 bZZI/Sn1oXiVblqn8ga49CRxtSaAnwJdebKnfVGZr9d0jvoULCYMyGAl9hSRXfcaVn8Y
 sASi4n2ezGXp27Ta+90qXkxdcsfFbpZ5Fh6VCn/thAz0b3+ENxANtNaB2PCyhbJf+KH8
 iCVv93xMuQgPoNlJLHMz2gSoQgcSHcz1W1bMy92lQOh83N8b2xO1fZZ2abuhbErd6RY1
 nkXTMwgBgmcTph+6izwzMshyTRoQX0OfjRTgH00+Dbd/eOM42PC6+7WVITWdTpB/zSQL Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3900psdj5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 04:19:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15B4FB0V102576;
        Fri, 11 Jun 2021 04:19:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by userp3020.oracle.com with ESMTP id 390k1thg7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 04:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA4NSW5rfaK+vQszKILoqtYF1OFCKfgu192jWw+93NaVWGZG5a74eaC5T/ri7Ga1M94+Mg6xVDi6F6HV7TadRimyx54Zpkp6DHpwLa84cvuY2IRi327J9gyFUq0DvpUG8vQhB2PGZEyYl1hlRxel1dXgPe/Q+lOLrVzZHLtThQ2G88l7Px3bFYhQMl4061DkRihEpnNodMzQD6c31QnLZUwfALHhedFiM91Ox1Jf0NqjEdIJ0yCRNjosT9HAViXWtehbhx/Wi/mNGEwJjyn1TXrYSoEE1g5FjFEIC9SZy52h5gLXzbpm8xKnyIN1EqbuVxNj5mZUzzrEMlEQy43t7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTmR8iWRdiLVfg5Kg/DbDnCyUN6OyaktdDfnoFAfkA4=;
 b=f/Qr3/m6M65ozKtRdRk/sAjmeD3XissQLPV2kOiIoRAnFOsMBIN4vdtJ5eKP6wda7796uT9K16XYar9t2DMyYLPMUM0YhKnaSCoFf+BaLHjMIPE5SOyoC8HBJoZOe9RPfG/iYjadMvoQOnSx9n5cYZBilj0ZOT1XwQq1X5GMO62hZoth5WbNPB0iLoeLRMIzQMa8cUO91AY/gT4iP8juNMdigiLX8OevknpKJ2GeA3msNJ5Tr4dVM0JcQKMVwkRZMJFItlGE5vep2U+uHkEkRw8MPnBMw0S6UEJ5Qx0/P0CM7HJL2gbei31Z2PEg81dGdIHCPz6Nq75foQVFaR/DIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTmR8iWRdiLVfg5Kg/DbDnCyUN6OyaktdDfnoFAfkA4=;
 b=FoCLxgiB2dSZiciwPMyaAKqgOe6Wd2J1uEC6TiVgusTgSzgHGUCm+bk+erZWBQOsZRI/8luxDUu5pTOhuDdgJhBaNQebN5G/lVcu6sUkebY6AzZfKm8pU2Zv8osZjOydHVdTN1w2M2/WukCCzPG0xK8HgQ7EL3dIfOSilT6uVOk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4303.namprd10.prod.outlook.com (2603:10b6:208:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 04:19:07 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 04:19:07 +0000
Subject: Re: [PATCH 2/9] btrfs: add compressed_bio::io_sectors to trace
 compressed bio more elegantly
To:     Qu Wenruo <wqu@suse.com>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-3-wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <1d315909-b51c-c74a-a7f2-60d71b637886@oracle.com>
Date:   Fri, 11 Jun 2021 12:18:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210611013114.57264-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR02CA0117.apcprd02.prod.outlook.com
 (2603:1096:4:92::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR02CA0117.apcprd02.prod.outlook.com (2603:1096:4:92::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 04:19:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43b65719-12b4-45b5-5add-08d92c900e41
X-MS-TrafficTypeDiagnostic: MN2PR10MB4303:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4303B31C514442881C2841B0E5349@MN2PR10MB4303.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aa9a+GLPhxtOlP748+8uJLeJ2RzQ+h7S62xc3mAwNsJQHyyEeOcSHyyLczgJvoGjU0UctfN/iRt1XPizzXoNJPleOZ35e6X4ngvasgDL+OxjJMVk7HTm4ArItHmZe3eJlrAVF8/4n9I4yBcTDqjy/mK8ES6brgS0qhA4VPILWFwIQFglLBN6Bnw8B3oNADuf57xpxgtcC8DF2537rtKICXvCpZZASeLH2lZiMMVUx4HBnIpwhN+rgfE0GGZUe7rVCcp4+qiX2AxH2Ee2JahsRQzqwdzxB0MM/uRe/2FXhrBB02vzKBnmRZGlhJ/1v9NZfp2nHa4AzSx0lV4GFnggjTST0Ys0W/rMbgTD4XJHi7P7XM0EkqQlnwfp6hFTxaYIMuhuELkbMT566HG3kKczXpxMVoaRgiAJdYrtd4ysyy7MJ9vcew1VTFZggieoniLaGMoWwnHyETevi1vYUSa4yO1BMj4rwSUg1tqtUg0J5BWXZ+CtA1S5N/RUbz8I1BotxGYy82Es7myCKGJIH713s1TG8otGdAxi1tI3A4SGh0KVF7pp+hB8tMn9gwwt67QKcG1JB0++QhDEF4tcrYguZ4srYtcmrERW2y7v1wcTOc2wYldebCVWIE5c3r5XKrrc3u21Cr6KVV1nLHGzvXZWoEU+NddJ3T6nW5WYyL6tn+SVIpHiP/DGQSkHdgm5SOB7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39860400002)(6486002)(956004)(186003)(2616005)(31686004)(44832011)(26005)(16576012)(6666004)(6916009)(53546011)(16526019)(316002)(2906002)(66556008)(31696002)(478600001)(36756003)(5660300002)(8936002)(66946007)(83380400001)(66476007)(4326008)(8676002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0VDNElJSjdBdFV2VmlUTERMekxtRUNUSUxPdkFpVGJCMEU2VmhBRXAzSUNB?=
 =?utf-8?B?Tmk4dU0yajFoSVpFR3o3QkhpZGxLZjhXOXhqZG9qUVVaTUtDRU5BQ3F5Tzly?=
 =?utf-8?B?Z3g2YVkveHkwMDVqM0VMOTRiWGJJcmNCdlcwUWFpbGxldXV5Y1diUStyTG9y?=
 =?utf-8?B?N3MvL2JvTk1sTlFTRW5DQlNWUzdMcWVIaE9MUzZNWDRKN2dMMXFzU3dUNzRx?=
 =?utf-8?B?eWVZaThKTUdyeTlHaTdsUTA1RWtsU3pNSEhvOEZPbVlKOStaZExpL0JaL1Bu?=
 =?utf-8?B?THluaElxRXgyaFVjYkhodmdVTmRseWxvQUhPdXBnWHA4TUFmMlY2RDVicE53?=
 =?utf-8?B?T1N3TG5MY21VV1BKRjRzbnE1aldEWVlzY2JydXorckJuK3U5dm4yNzZzd1Q0?=
 =?utf-8?B?UkZDOFBHekEva0c4Zjh3cDZpVEJOeW9hSkphMTIxakRQbDVCa29uTGtDUDZn?=
 =?utf-8?B?YWc3NjBFc3c5SW9KRzNodVdpd1lRZWRkRm5OdUdXVC9YazRYRm10MDRNSWFi?=
 =?utf-8?B?a0V5eUx1Q1dMenkrVE5mY1BFSDB2RGNtbEJrOTlqZTIycEUzWFdwYTQ5QldB?=
 =?utf-8?B?QURSVU5uRnVRUUg5YnI2a0ZFRWJ4emROM1pNQjFZWXRYcDJCMkp5QkhORlJp?=
 =?utf-8?B?U0N5eGFodW1IMmhDYXI3UXdTQXhEZEVwbTFSMHRqaHZxZUhoN0RSU0lBNUhi?=
 =?utf-8?B?QjBwTnkrTFNISXJmZnhCTk1RbmtVK1VzdjZtWDBIOUY2MHlyZEVvUWdDdXdH?=
 =?utf-8?B?ME01MytWUWdRWEFXV1lGMWFOOEYrdlJZZUIza21rUFN5VDV2bTR3T00venR0?=
 =?utf-8?B?aGc3cjdsamE5ZmZUdlJtemlhblBFd1p3OG5MTDBTSDQzSnFrclNuZlQwTGt5?=
 =?utf-8?B?SmJlTERsV2xlTlBZT3NISTE1SmUxY0JJUjJ2R1BFNzlIRzJVdnI3d2JhT0xh?=
 =?utf-8?B?WFZLTytIREVhTHJxM3lKdHRiWk9ZRktpMzYwNXVZdmZDMlNUQnA0cTduOXFS?=
 =?utf-8?B?VlU5SjRiYkkyZnpwU3dpU2Q3Z0RrekF4ZHUwb1IyK1BKSFhCbnBUZFhkSFd4?=
 =?utf-8?B?K0JtYTRHMEhHRW0vclRlcmpNam9kVmxJWHdRSEhmcjZrelFIMGo5VytpT3hQ?=
 =?utf-8?B?V0VidHZJWVJCd1dDdXpJQXUyM2hXWWdTbHd1UitYNGFCallzb3RMWE5KbEhl?=
 =?utf-8?B?OHRCRllJTC83Z2s3SlpQaThGTUR1Y0RBSENmOVhmTGgreFk3UzNlY2J4MUxo?=
 =?utf-8?B?OG9RazVJa3RVb1lpekZTeFkwbzJIMHd4bnE5ZjNJc0t1VFlKdVk0QXFMY3FY?=
 =?utf-8?B?WTlFUkhmcTI5RkZiUm9JMVp3MzRpU1VpVlQ5U3VZNjk0WEdoeXRoYStXOXRO?=
 =?utf-8?B?RzliYm9WRXJhNVFkdUYwTlJITDJmblNObDNvM2tEWEJsdWFMME1Vc2Y1UlY3?=
 =?utf-8?B?VUZFOHZobW5BSVByU0wvZklITDZZVUY2dkxFaXVjUXdINDAwNmVpY3Q1NS9r?=
 =?utf-8?B?dnNyTGdqSlJ4dFFiMHE0ODA3SENWODErVFd0Z2kzYTB0cUltcFQ2TDdOTURH?=
 =?utf-8?B?Q1B4R2huK1lOMHd0V21IVktvYzRFdWdrZlZoNFh4a1JIZkhFZXhZc2dLQ3B3?=
 =?utf-8?B?VUdvUytDam5PSjdVT1kvUm82L0JlQ0taNEVyUnNkdFFZN3N3amtxV2l0ZFZm?=
 =?utf-8?B?NWpnaVlOcW1IbGsyZUxOZGYvMitqNjJOM0kvNkcwd1Z3aVlBemdMcEc3QWVT?=
 =?utf-8?Q?UydJG10GqcplvvGNBI+if+Zw3yyvbtAeS0b5wYi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b65719-12b4-45b5-5add-08d92c900e41
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 04:19:07.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FH+9gG+WSKUNZdAIkCXImRSZiIcrruKltUw93DpneeociK0Yk5UfWvEwMB6MM0GJxJfVRC7FgvS7EQ9MGhk/PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4303
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106110026
X-Proofpoint-GUID: Q7LexPLEWlDmUtwp1SBcwQQAKf1TuyrY
X-Proofpoint-ORIG-GUID: Q7LexPLEWlDmUtwp1SBcwQQAKf1TuyrY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110026
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/6/21 9:31 am, Qu Wenruo wrote:
> For btrfs_submit_compressed_read() and btrfs_submit_compressed_write(),
> we have a pretty weird dance around compressed_bio::io_sectors:

I don't see io_sectors member for the struct compressed_bio in the 
current misc-next. It is not mentioned in the cover letter, but is this 
series a part of some other patch set yet to integrate into misc-next? 
OR can this series be re-based on current misc-next?

Thanks, Anand


> 
>    btrfs_submit_compressed_read/write()
>    {
> 	cb = kmalloc()
> 	refcount_set(&cb->pending_bios, 0);
> 	bio = btrfs_alloc_bio();
> 
> 	/* NOTE here, we haven't yet submitted any bio */
> 	refcount_set(&cb->pending_bios, 1);
> 
> 	for (pg_index = 0; pg_index < cb->nr_pages; pg_index++) {
> 		if (submit) {
> 			/* Here we submit bio, but we always have one
> 			 * extra pending_bios */
> 			refcount_inc(&cb->pending_bios);
> 			ret = btrfs_map_bio();
> 		}
> 	}
> 
> 	/* Submit the last bio */
> 	ret = btrfs_map_bio();
>    }
> 
> There are two reasons why we do this:
> 
> - compressed_bio::pending_bios is a refcount
>    Thus if it's reduced to 0, it can not be increased again.
> 
> - To ensure the compressed_bio is not freed by some submitted bios
>    If the submitted bio is finished before the next bio submitted,
>    we can free the compressed_bio completely.
> 
> But the above code is sometimes confusing, and we can do it better by
> just introduce a new member, compressed_bio::io_sectors.
> 
> With that member, we can easily distinguish if we're really the last
> bio at endio time, and even allows us to remove some BUG_ON() later,
> as we now know how many bytes are not yet submitted.
> 
> With this new member, now compressed_bio::pending_bios really indicates
> the pending bios, without any special handling needed.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/compression.c | 71 ++++++++++++++++++++++--------------------
>   fs/btrfs/compression.h | 10 +++++-
>   2 files changed, 47 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index fc4f37adb7b7..c9dbe306f6ba 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -193,6 +193,34 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
>   	return 0;
>   }
>   
> +/*
> + * Reduce bio and io accounting for a compressed_bio with its coresponding bio.
> + *
> + * Return true if there is no pending bio nor io.
> + * Return false otherwise.
> + */
> +static bool dec_and_test_compressed_bio(struct compressed_bio *cb,
> +					struct bio *bio)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
> +	unsigned int bi_size = bio->bi_iter.bi_size;
> +	bool last_bio = false;
> +	bool last_io = false;
> +
> +	if (bio->bi_status)
> +		cb->errors = 1;
> +
> +	last_bio = atomic_dec_and_test(&cb->pending_bios);
> +	last_io = atomic_sub_and_test(bi_size >> fs_info->sectorsize_bits,
> +				       &cb->io_sectors);
> +
> +	/*
> +	 * We can only finish the compressed bio if no pending bio and all io
> +	 * submitted.
> +	 */
> +	return last_bio && last_io;
> +}
> +
>   /* when we finish reading compressed pages from the disk, we
>    * decompress them and then run the bio end_io routines on the
>    * decompressed pages (in the inode address space).
> @@ -212,13 +240,7 @@ static void end_compressed_bio_read(struct bio *bio)
>   	unsigned int mirror = btrfs_io_bio(bio)->mirror_num;
>   	int ret = 0;
>   
> -	if (bio->bi_status)
> -		cb->errors = 1;
> -
> -	/* if there are more bios still pending for this compressed
> -	 * extent, just exit
> -	 */
> -	if (!refcount_dec_and_test(&cb->pending_bios))
> +	if (!dec_and_test_compressed_bio(cb, bio))
>   		goto out;
>   
>   	/*
> @@ -336,13 +358,7 @@ static void end_compressed_bio_write(struct bio *bio)
>   	struct page *page;
>   	unsigned long index;
>   
> -	if (bio->bi_status)
> -		cb->errors = 1;
> -
> -	/* if there are more bios still pending for this compressed
> -	 * extent, just exit
> -	 */
> -	if (!refcount_dec_and_test(&cb->pending_bios))
> +	if (!dec_and_test_compressed_bio(cb, bio))
>   		goto out;
>   
>   	/* ok, we're the last bio for this extent, step one is to
> @@ -408,7 +424,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   	cb = kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);
>   	if (!cb)
>   		return BLK_STS_RESOURCE;
> -	refcount_set(&cb->pending_bios, 0);
> +	atomic_set(&cb->pending_bios, 0);
> +	atomic_set(&cb->io_sectors, compressed_len >> fs_info->sectorsize_bits);
>   	cb->errors = 0;
>   	cb->inode = &inode->vfs_inode;
>   	cb->start = start;
> @@ -441,7 +458,6 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   		bio->bi_opf |= REQ_CGROUP_PUNT;
>   		kthread_associate_blkcg(blkcg_css);
>   	}
> -	refcount_set(&cb->pending_bios, 1);
>   
>   	/* create and submit bios for the compressed pages */
>   	bytes_left = compressed_len;
> @@ -462,13 +478,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   
>   		page->mapping = NULL;
>   		if (submit || len < PAGE_SIZE) {
> -			/*
> -			 * inc the count before we submit the bio so
> -			 * we know the end IO handler won't happen before
> -			 * we inc the count.  Otherwise, the cb might get
> -			 * freed before we're done setting it up
> -			 */
> -			refcount_inc(&cb->pending_bios);
> +			atomic_inc(&cb->pending_bios);
>   			ret = btrfs_bio_wq_end_io(fs_info, bio,
>   						  BTRFS_WQ_ENDIO_DATA);
>   			BUG_ON(ret); /* -ENOMEM */
> @@ -506,6 +516,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   		cond_resched();
>   	}
>   
> +	atomic_inc(&cb->pending_bios);
>   	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
>   	BUG_ON(ret); /* -ENOMEM */
>   
> @@ -689,7 +700,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   	if (!cb)
>   		goto out;
>   
> -	refcount_set(&cb->pending_bios, 0);
> +	atomic_set(&cb->pending_bios, 0);
> +	atomic_set(&cb->io_sectors, compressed_len >> fs_info->sectorsize_bits);
>   	cb->errors = 0;
>   	cb->inode = inode;
>   	cb->mirror_num = mirror_num;
> @@ -734,7 +746,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   	comp_bio->bi_opf = REQ_OP_READ;
>   	comp_bio->bi_private = cb;
>   	comp_bio->bi_end_io = end_compressed_bio_read;
> -	refcount_set(&cb->pending_bios, 1);
>   
>   	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
>   		u32 pg_len = PAGE_SIZE;
> @@ -763,18 +774,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   		if (submit || bio_add_page(comp_bio, page, pg_len, 0) < pg_len) {
>   			unsigned int nr_sectors;
>   
> +			atomic_inc(&cb->pending_bios);
>   			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
>   						  BTRFS_WQ_ENDIO_DATA);
>   			BUG_ON(ret); /* -ENOMEM */
>   
> -			/*
> -			 * inc the count before we submit the bio so
> -			 * we know the end IO handler won't happen before
> -			 * we inc the count.  Otherwise, the cb might get
> -			 * freed before we're done setting it up
> -			 */
> -			refcount_inc(&cb->pending_bios);
> -
>   			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
>   			BUG_ON(ret); /* -ENOMEM */
>   
> @@ -798,6 +802,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
>   		cur_disk_byte += pg_len;
>   	}
>   
> +	atomic_inc(&cb->pending_bios);
>   	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
>   	BUG_ON(ret); /* -ENOMEM */
>   
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 8001b700ea3a..3df3262fedcd 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -29,7 +29,15 @@ struct btrfs_inode;
>   
>   struct compressed_bio {
>   	/* number of bios pending for this compressed extent */
> -	refcount_t pending_bios;
> +	atomic_t pending_bios;
> +
> +	/*
> +	 * Number of sectors which hasn't finished.
> +	 *
> +	 * Combined with pending_bios, we can manually finish the compressed_bio
> +	 * if we hit some error while there is still some pages not added.
> +	 */
> +	atomic_t io_sectors;
>   
>   	/* the pages with the compressed data on them */
>   	struct page **compressed_pages;
> 

