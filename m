Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7874C62B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 06:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiB1Fuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 00:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiB1Fuu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 00:50:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934357498
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 21:50:11 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RLjqKN008247;
        Mon, 28 Feb 2022 05:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Pgpx5SJDZymGNY3PK6XxH0MmgXVgbt/KW9wPMAeuQZ4=;
 b=yrkq9ryBclKhUTFDvunTokIH6AZvp6sJwyGi+cRaHND4w5CjiW7YzZfYuWDu+4iyDxMi
 PxSYBrCzGZoVW/bS/zE/61XtuTWg2VIllcUPFuxJuP6LnpQH1LaEL9FBH36ewpxEhlLX
 DVMgC/4iTUWKIx9rEjFy2JMipncYKxJ4LB/4y0c3SNkOmc8Ofn4u0vHn5f3c9ldB4TTb
 qfFvZEusO7yLK+zYrQ9qnNFroQsqoGLQ51pHeFucJctpggakjy45I+SfI5Z4Z1knwqpT
 thYQiA8K8VVE6GyF+HcQbIi1DkSm3QHzsQaLK3rJwf7vwqpgx0vgssy0Ks2mg3n/pqL7 QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efb02k6gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 05:50:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S5jwad187141;
        Mon, 28 Feb 2022 05:50:04 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3030.oracle.com with ESMTP id 3ef9auwh7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 05:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6f9Vfxij//oGVAit8oT0Q7DgZ/X5/VfIaYCf1OZuZNAlhIHrHqBBoxtVfd3ypUkmZgJgvGFoZlCsVzdEiJsrGSlC0IhLNXBcdQ8FIiCXvAKPdfEIOeBqELNjMhuptmj51u1ZD463hfoGqmOCGiY8e9UPV41WaBfZh+u5RF/ZLeZO18uQcsk9auQSlJHh97GMCssUcweDMOsoZ0cERdYkdakz/vJzEzw6PEUjVqS/uGVELYCR1j9MyXncJOYWlfd9wXYI1j1RxyKd9uqKWdKO39SizDQhuI0PBzbFagAWwX6+QGvbHEKRFoNzbTcg0Vv/UHB9KrG7jdci2OB9Xnurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgpx5SJDZymGNY3PK6XxH0MmgXVgbt/KW9wPMAeuQZ4=;
 b=eW64LK6d4kSbURZfnnhSjiZyQu8zkBhF782Sw4TV8qOan6bO+i9urtoaa+KoTUMduW2VIMGyjTRf1bKQg4GtokD9KnSXIYVBORjFfCS4ElWtmg2FThZxVMDb2BADV07hcNP8pH6HvZUowPkr6npdXvBvu1HLtbl2zDSsvqbba3m6XUrtRMb7WQ2R4I2VH9mQ0d76jwTDUwyG5ceuziZpJgx+mvEjtBwr+ebESEP8ukYfUI0MV0/cOnwb3tq/RsVpDDG7MaAJiM5qN5+KpdD/vrA1JyGaqRoHP+d8hMUXD9VdCj171MlQDwKB3hvZgpAD6masTT9HM2y8aCHPQ0YjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgpx5SJDZymGNY3PK6XxH0MmgXVgbt/KW9wPMAeuQZ4=;
 b=FWW84D6Q11KUlwYh6+5F1vB2Box4VcDlfw/HbZ7fzeNS9dhZuuavy7arG5tlmzjwe5ZlMk3AaDwGbpY9hQgCgY60QESFeA46TkiTlLxcn2gRywRSWaLLGTTLOzZu08sJ3k11ABYsy6fVqzjzkuH/Pg/F7uLUtzw5c3KAaa0BjsI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB3644.namprd10.prod.outlook.com (2603:10b6:5:17f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 05:50:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 05:50:01 +0000
Message-ID: <7d7dcef9-93c0-59f9-b553-f15b6a443f0f@oracle.com>
Date:   Mon, 28 Feb 2022 13:49:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>, linux-btrfs@vger.kernel.org
References: <ad2279d1be9457b5b0a7dc883f7733666abb1ef8.1646005849.git.wqu@suse.com>
 <264cfb18-70ed-c20f-ba28-3fad002ed645@oracle.com>
 <75c0e9c7-165f-3a4a-dda1-ebd0cc092392@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <75c0e9c7-165f-3a4a-dda1-ebd0cc092392@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caecc258-2066-45c0-7fdd-08d9fa7e2910
X-MS-TrafficTypeDiagnostic: DM6PR10MB3644:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3644B7A977C0100BC69D719BE5019@DM6PR10MB3644.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjHOKLqFBtp3UJcNEm8RHaa9wpSwGY0y/rGKC3A+eNkcaYuSnU28pJc1htlSXQ0IjMZ6x5d0Px/oVKNO5MolK+QTdPHTALl5Wmkoijp8ngfx6GkON0JxJ+BsySn4KutMd4W48ksaNSqFy6GjNcO7G7jn5T3teKlwrCN0D375rps7SAma3+gN66zj1FVX3XIpuWWLjc2KEZHwFIiyN7QBPAVGwxFXE+luAQPXD6ztceAt+0w0jl+TfxHrV80reSOAtplDym/U4/ub83zCGfyQAGJHj2/EgRxKMuUmWfbX7KGm3JrrOq0yCItzCNDtvEKCSR7PPjeKxppWGDp2xDfyaeCEClgguWMdzSNQys2PYFI4yg7Mu2vT3PES/R+zNUOWilRfj31q9yS553Ex76ZhIFUsz33aN1phQYDpD2mzG19h69S7NXmhHJs24SzHa7PcsQBzd3SutkubnMiOu/SKt8jGJycbCJWjQqANOkEaoz9Qn0PxZXoBLsAFSYp0ybDmcsqDaytR/PhpVnOU4Rm/QqQmY2fnmlrCdnqK6zI0kVJ7ITphZi9m4SE+8eYPh4ZKK04oJIxSxSce+PIEXmWtZaoK6qCV6wwfOYNN9Hv0vW+nZ2TcQqbI7O/IxgfdzvDiTA6MEOCC0XXGWQFvgc9PLOm1P3jKjy99wM1AH4hmTFr8ILj+gLoOjLKlPVBqlQKILWu7ClgScoOEQXL9POV3e4y5Y249tGMNKYOEofn8cTGYP7fTOpZcppIbhRk1UUwcIkisMVzN98TWDOMKaXNGMDwkgzCstcrBqy4b7eKNupC5q+gKPewEoJXrl9bgRpjZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31686004)(36756003)(316002)(86362001)(2616005)(5660300002)(2906002)(6506007)(38100700002)(6666004)(66574015)(6486002)(53546011)(966005)(110136005)(8936002)(26005)(6512007)(31696002)(66946007)(66476007)(66556008)(508600001)(4326008)(44832011)(8676002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXd4bVpQZndJeFYyemhkVUF1YWUwSTZ4dlAzM3o2cUQrVitYcnZ1TEREZ1o1?=
 =?utf-8?B?cUNUM2htbGJ3Q0ozT3JPMCtPUnoyZHUwY0FTVWZrZkNnb1JLWjZXK0I0RWJs?=
 =?utf-8?B?dnRmZno0VEU0TXdIRDlDbHMzT09ZOG03UURZVzhlK3d6MlpXSlFnaEFkd2Zy?=
 =?utf-8?B?cVFWUXQ0YzJxc0RqMWNkbnBMWDVjRWQ1RGc4Q1AvL0IwYk5rV3B1UmhOU3J4?=
 =?utf-8?B?TWcvYnROT2F6QkZITnhvNE8rYk9CUkNsY0h0ZnF6dmRJSXRwQ3c5a1BwZjVn?=
 =?utf-8?B?WW1aWll0RDYvOEdBYjJIbVZwMmlnU1pqbUNNdDdYR3o3YStCSlZKQjcvdVRY?=
 =?utf-8?B?dTAvaHZQaEV3OGdTSUM2OXgrMDlXL2M0QjhrVHo5b2RvY1NjWTBZUGZSSGhj?=
 =?utf-8?B?NkZHK2pyU2kxY3RnVThBWW9SQUVmdG55bHliUG5laGVPeTloTGU1WjRuR1VV?=
 =?utf-8?B?NUVDT2NvQWNQK2VLSmtiY21icE93V05LTWdjcDEvTU1RZks1K2ttQ0luRkgr?=
 =?utf-8?B?cEdGOU81cklNS3FBcmNSUDZWRWZ5QXBpQjBEWWhoTVV6SzFHZWhwNWF5eFV2?=
 =?utf-8?B?ODZQVkVnL0tGeWt2dDBVbXhHbmcwZk00VlBVMDBaSXU1cmM2eG1UakxwMUp3?=
 =?utf-8?B?TG42ZXQwbVlhTWE3Zm8xMG1hTWRWcHdtY3JhQ21YODU0V0k1ZytUVHcvZncy?=
 =?utf-8?B?eGVCcGwyVnFNWCtZcFdydC94RHR0cW1wNnIyWXE2aU5OZFRRSVZDQU1uRDNn?=
 =?utf-8?B?bER0cnRCU2NzcU5yajlKKzJXYS9QaG9yMzFkZEoxY25qSkxZbXFVRm1obFJG?=
 =?utf-8?B?a3ZtNnp1QjREV0U0RWpOQmg5a0RBbkJnMU1vK0dSTnV5V0hKcjg5Rko0Vmtj?=
 =?utf-8?B?ZklmWTEwZG80MlRtQWtLZlpHdUdlcmNkR2tPeDVxSkpUaUNJWmUyb2Jod0JR?=
 =?utf-8?B?Ry8wUlVjZ0RBTmJleGtlSVNaRFBTUHlxTHN1ZEN2WlpsRmFPSzBPQjE5L0Uz?=
 =?utf-8?B?MnliVTVBMncyMk9UdjVUL0s2Rm9CdDlMU2lJeTRlaHd1azIwWFErajkzenhO?=
 =?utf-8?B?bnhtV0JpYlNDQzZiKzltY2xuSitoYUlkWXo3U1lsbi8xQmluRlVPamVuM05G?=
 =?utf-8?B?RnNid1NndGZDc1VXVkdJa1pCVlkvRHRLbm9sNUNLTDZPZEwvOG9MVFE2dDY1?=
 =?utf-8?B?LzVuZEdacmJMbXErOWVQc3NRWTc4WWtmNndudDgrdjJwWlhXQ0tpNHdEeE1E?=
 =?utf-8?B?WXhWckxCdkU1cXpoUFJkWDdVMTVBSG5ZZ3BSbVE4eGFlUkM5Z0FOV3VUK05D?=
 =?utf-8?B?MEhFQUpNMmpPRHB1Rlo3ZHl6cEl3Unl6UXhIS2daL0FmWm1uRG1mU3p5Qmhx?=
 =?utf-8?B?cWlURkNlM0dhakt1QXhxSko3OEdRQk1CeUlnU3BHd2NtdDR1MUcwR3k1dGh1?=
 =?utf-8?B?NDQvWVlLR0laWmNOS2VjZE4rYURKRnplYU1sOFUrdENDVk5FMHp4U1AyU0NN?=
 =?utf-8?B?bldjOTVROTdrdWthcGxUWldQV0EySllFRjl5aGthSDZ5ckt0ak8yL2hlbFpO?=
 =?utf-8?B?Ri8ySzN0REliVkxub05IV3NTUWZzNzgzc2lKdHJjdnYzSnVSMkdSc05VS3ZX?=
 =?utf-8?B?d1JwYXdpSEdSTEoySGFEWDc5RFBTemp1eEdWM2dGUTlGaXJNdHFKU0ZzaXFv?=
 =?utf-8?B?OGFEUXRTYVJ0Q1B1clZ0WG9iNjBVMjdPMlRlWFRlQmdnYnZGWnJHVzJBRDE4?=
 =?utf-8?B?NkhXNkFpU1FtZ25vaG93bmlXQTg0YW5sby93Y1NxNDFJS1p4QkRZcERVQ0Fn?=
 =?utf-8?B?OWFXMDVVZlhBOVNkbzFwMXRLcnlieDBmZWdIMEV0OURlV0JaSlJETzRvOVlZ?=
 =?utf-8?B?VGZnYUtNYVJDOGhiUG5GN3NMYXhFU25hY3FyV3phcy90T2w2QU44ZlN0RHl2?=
 =?utf-8?B?akVqQkk4MStBeWZVMmh0QUVLVW5MSXg0WXBXbVNjb09XemR2RnZUcDQ5MWhG?=
 =?utf-8?B?NGJxaWFHWUh0NHVwYzVvaEFiOXp2Zk1nK3UyWWpVajduUUx3MGFicEVjQnhz?=
 =?utf-8?B?YVoxQ013TUhFMTVBcUoxQWlzMUtxaFBoWEJmcFIzR0lLMVdFWXE1TzcxdGJm?=
 =?utf-8?B?dFpZWGxKK0c1aXJyVnBJWitHbW83Y0xJL2NLdHRtbTNGOWxDNGhwSDAyc2tJ?=
 =?utf-8?Q?jRkDQtmq1JquI5qBMNemzvo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caecc258-2066-45c0-7fdd-08d9fa7e2910
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 05:50:01.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAlySaV4ciLfMU4mUO4882i2k7PTbJYkNJLePXApMkiIhk17hNjjZLs8hvnMs0V31pxj/VTajgVb0liCdqmX/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3644
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280034
X-Proofpoint-GUID: cNgfJ2Fg9YkvGK2X3WDgbuDuT-BMmw03
X-Proofpoint-ORIG-GUID: cNgfJ2Fg9YkvGK2X3WDgbuDuT-BMmw03
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/02/2022 11:17, Qu Wenruo wrote:
> 
> 
> On 2022/2/28 11:08, Anand Jain wrote:
>> On 28/02/2022 07:51, Qu Wenruo wrote:
>>> [BUG]
>>> There is a report that a btrfs has a bad super block num devices.
>>>
>>> This makes btrfs to reject the fs completely.
>>>
>>
>>> [CAUSE]
>>> It's pretty straightforward, if super_num_devices doesn't match the
>>> deviecs we found in chunk tree, there must be some wrong with the fs
>>> thus we can reject the fs.
>>>
>>> But on the other hand, super_num_devices is not determinant counter,
>>> especially when we already have a correct counter after iterating the
>>> chunk tree.
>>
>> Cause analysis is incomplete, given that SB write is the last. The root
>> (and thus chunk tree) and super_num_devices will be consistent always.
>> Do we know how the miss-match happened?
> 
> Sorry, I should provide a full analyse on this.
> 
> In fact there is a window in device remove path that we first remove
> device item in chunk tree, and COMMIT transaction, then decrease the
> device counter (without commit transaction immediately).
> 
> In fact, there is already a TODO comment in btrfs_rm_dev_item() call
> inside btrfs_rm_device() saying exactly the same thing.
> 
> Thus if we got a power loss/reboot, like what the reporter is doing, it
> will cause such mismatch.


If sb write commit failed. Why isn't root read from the superblock
pointing to the old chunk tree with 3device items?

Thanks, Anand

> Thanks,
> Qu
> 
>>
>> Thanks, Anand
>>
>>
>>> [FIX]
>>> Make the super_num_devices check less strict, converting it from a hard
>>> error to a warning, and reset the value to a correct one for the current
>>> or next transaction commitment.
>>>
>>> Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
>>> Link:
>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/ 
>>>
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/volumes.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 74c8024d8f96..d0ba3ff21920 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info
>>> *fs_info)
>>>        * do another round of validation checks.
>>>        */
>>>       if (total_dev != fs_info->fs_devices->total_devices) {
>>> -        btrfs_err(fs_info,
>>> -       "super_num_devices %llu mismatch with num_devices %llu found
>>> here",
>>> +        btrfs_warn(fs_info,
>>> +       "super_num_devices %llu mismatch with num_devices %llu found
>>> here, will be repaired on next transaction commitment",
>>>                 btrfs_super_num_devices(fs_info->super_copy),
>>>                 total_dev);
>>> -        ret = -EINVAL;
>>> -        goto error;
>>> +        fs_info->fs_devices->total_devices = total_dev;
>>> +        btrfs_set_super_num_devices(fs_info->super_copy, total_dev);
>>>       }
>>>       if (btrfs_super_total_bytes(fs_info->super_copy) <
>>>           fs_info->fs_devices->total_rw_bytes) {
>>

