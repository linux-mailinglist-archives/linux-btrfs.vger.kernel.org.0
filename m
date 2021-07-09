Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31463C214D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 11:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhGIJQF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 05:16:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52712 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229559AbhGIJQE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 05:16:04 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1699CbrQ031236;
        Fri, 9 Jul 2021 09:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=daSccpQfD3jlTa/3+kVT15HWqiSGAXM8RWKQce2CTIw=;
 b=TZNCObncxN2fqHosrXYwWSdGIPPm4ug0dk8HcMq8Dhna8mxZmLBoigB4LbL9pVPN9f7J
 CVFsMLD3acbKdVhvhO0Jp18O4p4sqx3osOXg4WF2cF18Ez794zKR2N6aYJMERAAyZl4q
 ar5vKk2lFd1FTpYABKai1rJPMFcCYR1zTBktUD49Z5YGGkz1JQ5ezKbq966y4zltmNxP
 zwPglaB1/AZ5ZE73J7I1Cwu715Ttk6SVnKrj/uRcPTw+Vr1IBqExpMSwpj9N8hXLhiC7
 uxq+hj13jJ28PPZwooxes1YrM2q85aOSa6CR6T676QGTQ8Orwev4QPNgOaKMuT/45i+x EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39npbyjxyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 09:13:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16996cIO169739;
        Fri, 9 Jul 2021 09:13:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 39nbg7b0uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Jul 2021 09:13:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Occrh1W5YGzMp7finklTlDbfxhUcAKvAvsBJpsFh7NB3TpKwfUFnQe8l/re1JtzK3EAeSmkpTLLsGAppkF+6VSbRCpT+/GXAo4oM1U58I6WpICKco40hyOf61GSRFfiBG57h4YDtAJuXjLV55wW52p8dfg6N2mHgI048zv8lH5ZRajtWOX1UrC4yQSS2P7dcYRCrZ4okKdt3i6o3B6Re3MiF9fSZK0iraekpilp8XpWWPvXuLDRWVVvjMz6r8FIErKI9XCrnqkuVI3pOP3u6Ym2VxqDrW2FdZa8yOg45WSmVriHPnKQK2VMsh8/HBePCj+5Or4o45VchZFShTns0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daSccpQfD3jlTa/3+kVT15HWqiSGAXM8RWKQce2CTIw=;
 b=iUTGiIAJUmLy70UzXX8bTTqmXIb8VbrMzk8+u46sHR4N2ZR7kYqKPFjuIadPGeMPrDzxOBnd7P1U538rA6lIfVrcxNhuXKGXNWsJETVSgTn3F3sUX4gwkZisWKTPi+Kd+c644ynZDAu0M0Sp2+UpRn7MUTqyZW82qNnR/FUQi/7LJRzrGYc9XvA5FonzXhQuOiewe+IE72L4kCJxD82u9vi5VPF2CGEkyYr5o3BMxt6WHj5RSbwJJL93HUcL4nc1AcMhD1dofmzOxmLFxrrlaFi4Q/sv2SEaf60V445f/6jikwyBwyFFtqna2wvltsU8GOe/FDT0RlWn0wKH/P2uKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daSccpQfD3jlTa/3+kVT15HWqiSGAXM8RWKQce2CTIw=;
 b=pIYweBXCScFo7UOEWEE0mNMemhd/UReUaQAP9yKo5kKrwndyPuD7243LKk70SFJ981S2J/AU+mG5Kspx7eRD0hRkGLwrLhtXvqzCPw7clR1UF/ZmhNfqe3g2389Po7jJ9Z47P2wlEZA7Jy4z62FI+4UqvXi1F43Io5Gos0/0hUg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3854.namprd10.prod.outlook.com (2603:10b6:208:1b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 9 Jul
 2021 09:13:11 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 09:13:11 +0000
Subject: Re: [PATCH v6 01/15] btrfs: grab correct extent map for subpage
 compressed extent read
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-2-wqu@suse.com>
 <3d654aac-a0c5-fb2d-24d7-4508c8080e03@oracle.com>
 <6bc6b208-c376-85dd-910d-03d5b7478efe@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <33f8b740-6951-b5b4-2a49-c8d5d0ce944e@oracle.com>
Date:   Fri, 9 Jul 2021 17:13:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <6bc6b208-c376-85dd-910d-03d5b7478efe@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR02CA0068.apcprd02.prod.outlook.com (2603:1096:4:54::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 09:13:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c6dcb52-2f76-49ce-795a-08d942b9c654
X-MS-TrafficTypeDiagnostic: MN2PR10MB3854:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3854A45A2DFE29D62856C202E5189@MN2PR10MB3854.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uY5PDokIhd8QQgjSLIKRyP2G/Yg7el02LfvnR3zR77HFZeTfBcA4YleaMv82o3OmMDh/4Nlp8KXRftdMnOjM/gog3fcz9WHEBcnoiNmqUuys+95vlGB9JsA7FdgMmziFlxUkm0+fK9z0Yd0wiNUOygMg0nk2PSq2VYUERXzlDjke3TaJGI16IUpVZyrCbY9Y4dIavCv/Y1IWeW6CetT1wN/HI4sbB5zJY/qEK2qpLuplhbVmCSMtAgMFHSvT4r5EEfqDd6FFg1UE3INmbK1YigxBcJ+wo5YWdiwNWa5PZ8K9jzvA6NcCOB/5Trk/uGP1O9oOp4t+0x/965ohMFcjracy4g3nu1eJvDRUfZiy8ovdO1amXGEqf/ZHU8Ahr2ZexxaTggY/kF+Kdk4BFmaN0zBh2fYS/9d+amyW0gyGgIRjCzFVZMeDWRcMs+fgqB8WRuyNgTEr/8l3tu0enteLQIlMJGrG/gWOl2GIOzBxvqNgG7IvQTpxXMlSSUihro5n1DgS2R1Db3OGIBWOAnf6ijPTw+u7/6fWHDzNI+t6bhDZ+vH4OGa+/Lsa5oKukkg7+UdgwIRoclki7bF9mXvAzw1XVId4Dvtn5xO8ghAwXnW8VmfAMhQ91l5ri4ZM6beZOMyZiJkyOH1jtGYTexfWPaEBzkFFc3h/ArKNatjyhk9WChieUJ35cg7ILDlLcjZUwXj9AqEvvy9hNHGh+McSRuu8g7ROuoN9yg0Sd3RqTNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(39860400002)(396003)(83380400001)(26005)(8936002)(186003)(478600001)(36756003)(8676002)(316002)(38100700002)(16576012)(5660300002)(6486002)(110136005)(44832011)(66946007)(53546011)(86362001)(66556008)(31696002)(2906002)(956004)(2616005)(4326008)(31686004)(66476007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdYVHpHMXpEUUtiZVlxZk1tK1JsRHBzSWl5K05acC9rSkI3Nk9FVnR0emor?=
 =?utf-8?B?MjVKaFhjVG1NQzZqYjZSckpqTC9ncGxRUmhUWHdsYmUxdUtJZTYzQ2tnRERQ?=
 =?utf-8?B?THk1cjFUY3hQRGI1WUprOG9pSnFPelRLemlmWW9SaWhmaWdQWFh6TEh5RFpC?=
 =?utf-8?B?ZTRqcUgrTFlmRWlGVURoajluVEpIM0QvM1g2QmYyVzBySlZUQ2tzOHZBUmNp?=
 =?utf-8?B?NGtJbUNyaDFWaVBkUURVVW5zZGFkRjE4NEdQY0xkV1VXbE9RYktndHQ2SjNi?=
 =?utf-8?B?RGpxbEpNRFhhNU1WQzR0U1FOaUF0alRYWmE4aWFGZGtHNS94U2tIVWk2UzVD?=
 =?utf-8?B?S1gwUUg5TnQwbThjZTRWNjVJZ0syOUV6UVNQZm5JTU9aRTcxd002VGoyOXhV?=
 =?utf-8?B?dk55ekVPek5XVVdtUzdleWVDSEV3MUhaamF6ekdsK2lrZ2dtQXlpeUV6OHp4?=
 =?utf-8?B?R3BqUFRsdGEvQmxFQUw5T0RGWHN6TjZRcHd5M01sNjBzWU1FeXJ0eEFKanJ0?=
 =?utf-8?B?RW5MSllSdVkraGl0STNFVXZmcG1nSzRNSkFKWEZlbGZRemhGSXJJVkhoNkU4?=
 =?utf-8?B?M3dENW5ETWQrUDhDMFhyVFRTUW4zNmg4VUtueW54K1NUZGhwZlpQQ2J1REZC?=
 =?utf-8?B?QldpQkJsRGJlVkNmVmNRWmZpMEd3NkJlOG1IdS9LZVJaYWEwbGtSb3VyVFhi?=
 =?utf-8?B?ZDZZZWUwYlpZTTZIWnE0VnNMNFg3c0crSDBHVlBTSzhaS0syVGJyaFp5c3oy?=
 =?utf-8?B?N0dhcjY3M00vMjU1bWtiZmxRa1JCOVhIMENPTDdaWW9ZZFBmV2hoNE5LN0tO?=
 =?utf-8?B?ckRDNFhVMmhoUFNNKzI1UGtCckJncmxaVWI2TEVhblZXYitCTm5pcXJ3dlZR?=
 =?utf-8?B?ZWNESGlQTUxXWklJdENvL1hxU0p6VHdLcVZnVXIyZFo5alZCUHRjd2MrKzJh?=
 =?utf-8?B?YnY3Q2o5UThwcEE2cHdvdXp4N2xCbXBNU04zWkhCdUtaMlNiL0FpYUcyTkpT?=
 =?utf-8?B?UTZFMUFGUkw2Tnpud2tpLy8yY3lBM2pRZEk0aXVTNXJiZ1ZpV1RIWkJuTURx?=
 =?utf-8?B?ME5sOXY5NnlCKzA0QWxCejI4NmF6RERoUTFqUjdXSDZhYkpNMnMzQXNtcENk?=
 =?utf-8?B?bER4eTVmRjR3Q1FsWWVVTXFBRkFuUWQrS3VLTGNTTDV4V2dlYmd4ZndMTVJK?=
 =?utf-8?B?OEpPWVBMamZ3dk9nK1NZSUhueGFxUTdaSnA1ZmRwN09tcUIydUtEK2pYc1RX?=
 =?utf-8?B?dmpsVCtzUWlCajV2amNCeDJwbkpmTVBxaVZXcEE1Ui9aVmxCSVBJMXlMZ21H?=
 =?utf-8?B?Z1BJY2o2WlJKVmk1NE1TMWR4YUlZZm1MZW5ULzR1TVpUR3RRbXRYdG4velc1?=
 =?utf-8?B?VFdyWlFrdE9GY3NxQXZHWnJoSTA3dDc3bnc2WVEyTlBvMlFEVHppQ0pGL0Zm?=
 =?utf-8?B?T1ljcVJPZnl6TXB4VUoyWVhtTExydHZjc29JY0lOakx1cWdDdnhhTjVoYUlH?=
 =?utf-8?B?ZzhVWU5EREUvYzBMNEtsbDVlbEI3SkRKcnlTVFhLUFdKUWJsMkdYRWpnaDBz?=
 =?utf-8?B?Z0NaVndJejRCcWNwVE90aUwzWlVvcDV1T084cHkxL3Z5enZKY1VkenJuZzN2?=
 =?utf-8?B?LzgrTktZQXY2R0w4R0NZVTJVa3lhcmc0dGR0YS8yZHhzRzFyQ0J5bVowVVd4?=
 =?utf-8?B?azJ6RHkxdGpDcHcxUWlSdXUwU0F3aFQ4Kzh6WFUrZE8vcll5SkNhYUtiVkVB?=
 =?utf-8?Q?ed6maMjafUwX+1++NFDYH/NyLuCPVfAuOxSJeqF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6dcb52-2f76-49ce-795a-08d942b9c654
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 09:13:11.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GZVh9MhTnqq3uSUcsrOFpnBgGmPZPw1S4tmdKcxTEreHMr6yZQbHrs+Ojp4IOJqBf5BDD/7C6D0jCJU5OdUug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3854
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090046
X-Proofpoint-GUID: r7izkJ2gyI1AinmkO6YVssRcEghypvk5
X-Proofpoint-ORIG-GUID: r7izkJ2gyI1AinmkO6YVssRcEghypvk5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/7/21 3:06 pm, Qu Wenruo wrote:
> 
> 
> On 2021/7/8 下午2:50, Anand Jain wrote:
>> On 5/7/21 10:00 am, Qu Wenruo wrote:
>>> [BUG]
>>> When subpage compressed read write support is enabled, btrfs/038 always
>>> fail with EIO.
>>>
>>> A simplified script can easily trigger the problem:
>>>
>>>    mkfs.btrfs -f -s 4k $dev
>>>    mount $dev $mnt -o compress=lzo
>>>
>>>    xfs_io -f -c "truncate 118811" $mnt/foo
>>>    xfs_io -c "pwrite -S 0x0d -b 39987 92267 39987" $mnt/foo > /dev/null
>>>
>>>    sync
>>>    btrfs subvolume snapshot -r $mnt $mnt/mysnap1
>>>
>>>    xfs_io -c "pwrite -S 0x3e -b 80000 200000 80000" $mnt/foo > /dev/null
>>>    sync
>>>
>>>    xfs_io -c "pwrite -S 0xdc -b 10000 250000 10000" $mnt/foo > /dev/null
>>>    xfs_io -c "pwrite -S 0xff -b 10000 300000 10000" $mnt/foo > /dev/null
>>>
>>>    sync
>>>    btrfs subvolume snapshot -r $mnt $mnt/mysnap2
>>>
>>>    cat $mnt/mysnap2/foo
>>>    # Above cat will fail due to EIO
>>>
>>> [CAUSE]
>>> The problem is in btrfs_submit_compressed_read().
>>>
>>> When it tries to grab the extent map of the read range, it uses the
>>> following call:
>>>
>>>     em = lookup_extent_mapping(em_tree,
>>>                       page_offset(bio_first_page_all(bio)),
>>>                    fs_info->sectorsize);
>>>
>>> The problem is in the page_offset(bio_first_page_all(bio)) part.
>>>
>>> The offending inode has the following file extent layout
>>>
>>>          item 10 key (257 EXTENT_DATA 131072) itemoff 15639 itemsize 53
>>>                  generation 8 type 1 (regular)
>>>                  extent data disk byte 13680640 nr 4096
>>>                  extent data offset 0 nr 4096 ram 4096
>>>                  extent compression 0 (none)
>>>          item 11 key (257 EXTENT_DATA 135168) itemoff 15586 itemsize 53
>>>                  generation 8 type 1 (regular)
>>>                  extent data disk byte 0 nr 0
>>>          item 12 key (257 EXTENT_DATA 196608) itemoff 15533 itemsize 53
>>>                  generation 8 type 1 (regular)
>>>                  extent data disk byte 13676544 nr 4096
>>>                  extent data offset 0 nr 53248 ram 86016
>>>                  extent compression 2 (lzo)
>>>
>>
>>
>>
>>> And the bio passed in has the following parameters:
>>>
>>> page_offset(bio_first_page_all(bio))    = 131072
>>> bio_first_bvec_all(bio)->bv_offset    = 65536
>>>
>>> If we use page_offset(bio_first_page_all(bio) without adding bv_offset,
>>> we will get an extent map for file offset 131072, not 196608.
>>>
>>> This means we read uncompressed data from disk, and later decompression
>>> will definitely fail.
>>>
>>
>>
>>> [FIX]
>>> Take bv_offset into consideration when trying to grab an extent map.
>>>
>>> And add an ASSERT() to ensure we're really getting a compressed extent.
>>>
>>> Thankfully this won't affect anything but subpage, thus we wonly need to
>>> ensure this patch get merged before we enabled basic subpage support.
>>>
>>
>> Is it possible to simplify the test case?
> 
> I guess it's possible to simplify the test case further, but to me it
> doesn't make much sense.
> 
> We don't make test case for regression which is not in upstream.
> 
> And the existing test case is good enough to catch it anyway.
> 
> Furthermore, there is another bug just exposed and fixed locally, that
> in btrfS_do_readpage() we never reset @this_bio_flag, causing any later
> read being treated as compressed read.
> 
> There will be more small fixes for read path in next update.
> 
>> Why is this not an issue in
>> the case of the non-subpage filesystem?
> 
> Because for non-subpage case, bv_offset is always 0, as one page
> represents one sector.


  Ok.


  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> 
> Thanks,
> Qu
>>
>> Thanks, Anand
>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/compression.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>>> index 9a023ae0f98b..19da933c5f1c 100644
>>> --- a/fs/btrfs/compression.c
>>> +++ b/fs/btrfs/compression.c
>>> @@ -673,6 +673,7 @@ blk_status_t btrfs_submit_compressed_read(struct
>>> inode *inode, struct bio *bio,
>>>       struct page *page;
>>>       struct bio *comp_bio;
>>>       u64 cur_disk_byte = bio->bi_iter.bi_sector << 9;
>>> +    u64 file_offset;
>>>       u64 em_len;
>>>       u64 em_start;
>>>       struct extent_map *em;
>>> @@ -682,15 +683,17 @@ blk_status_t btrfs_submit_compressed_read(struct
>>> inode *inode, struct bio *bio,
>>>       em_tree = &BTRFS_I(inode)->extent_tree;
>>> +    file_offset = bio_first_bvec_all(bio)->bv_offset +
>>> +              page_offset(bio_first_page_all(bio));
>>> +
>>>       /* we need the actual starting offset of this extent in the 
>>> file */
>>>       read_lock(&em_tree->lock);
>>> -    em = lookup_extent_mapping(em_tree,
>>> -                   page_offset(bio_first_page_all(bio)),
>>> -                   fs_info->sectorsize);
>>> +    em = lookup_extent_mapping(em_tree, file_offset,
>>> fs_info->sectorsize);
>>>       read_unlock(&em_tree->lock);
>>>       if (!em)
>>>           return BLK_STS_IOERR;
>>> +    ASSERT(em->compress_type != BTRFS_COMPRESS_NONE);
>>>       compressed_len = em->block_len;
>>>       cb = kmalloc(compressed_bio_size(fs_info, compressed_len),
>>> GFP_NOFS);
>>>       if (!cb)
>>>
>>

