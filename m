Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32856D2E62
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Apr 2023 07:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDAFcH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Apr 2023 01:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDAFcG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Apr 2023 01:32:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69C1D93E
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Mar 2023 22:32:05 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3315OVoH003436;
        Sat, 1 Apr 2023 05:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jdPYKe8g/3K46bo5aFvPECaK6A8I5hhhm1IDcGF/Lik=;
 b=QOROm5TLb/Q8vjwVksZ9aRGuaNRNKOOkfkFzaK3thl8PYkGDGddcfYxR8cBMdL2b8AKS
 Q+r+LD5x4jqf11FsFf9hfD1lgOCu5qkkmPgfG3CFIJaBMTAymN6ml/XCXpFoKywpcyQB
 xeW9jrS3HVPikVVV6+6BEORR0WWj2Kyg5DELBi2glftBU/6yQiNFlvqgewKrdYlUXeo+
 OkYWI4oklUFvQC5M1/qIHOro3GcfES67pfKsuKMXGPlNKTTr6lXlo9GDFuEpCr/OpOhg
 /tsdcGT5VPKfjaIqOCBxGrX4lisko2o+S+xTVUx3CWzH4XCZIjYLJ2AyNOHTkthCwYLR +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcncr21e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Apr 2023 05:31:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3311XBDW022045;
        Sat, 1 Apr 2023 05:31:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppb23w8aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Apr 2023 05:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1f8FZsQwv22jiZCVxS5m+mPzCsDEpmpcq9mH3kiYWDmkYCk/Xm/JYJsCxlnbRhLYgv81ec4bNlgmKk1hf1AFgJ27++dXhffN/i8v+i2bXWkWtZLtuZtT0I+Bqjs4RKO5LidiBkPMUOu246jFBhZ/2z1+XNvRgSdOFAA3uSrWtfd1PZgUdhq7yKOeGeclRrxsmiYdLlCtXOyR4JZDGBhX4fBD7l9jX9BNBpEJHYCQicaPtOXTOtEZX8yDOGKTOCdi7o1nFCiWFTmdg+8RJERuyQUi2MLl4KagZ/n7hp/96K9Pgas615bsFpuRyEujOLZn23W+e4Iq9j3jJ0P9tnAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdPYKe8g/3K46bo5aFvPECaK6A8I5hhhm1IDcGF/Lik=;
 b=e0C/IuTG8Nnf+9lNwjhnU/VddhE3vv/GfkH7PCkopDy47TJPrfDlQCKkqA9IIfbP2lKumaybf6DBTcr1jDZMZhfWCOP/7khd3n1QjoJ8+imraMrLWd+xWzvuD6LQhKOsfRtgUQGXBAtmQbNfnNrhuyGGQhc0aDx8xDYIuUSUvVYyhlmo/7hTn+g2v6KOe/+nz5fbpWUu87qZ9KNjocAAu8VoIfgjhq+jY6f4vnD3fpG89LEowwl5s+dvQzWzIz8iOr02k3RjK7bay+b+2rCqn4GwkFaLsGS57NyBslkC8Fg+RizhbeYZRUhGecvv8Fr/R5BDHi1ReiOk5y2z4HV5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdPYKe8g/3K46bo5aFvPECaK6A8I5hhhm1IDcGF/Lik=;
 b=UKtmITRPUBI68Pq3QJ0HmwhFCXe2ttwaBCWUstgb9F9Cpb0DeHnAhZ4WuwcaYslLOGi1D8hVdydz72brAJuBZq5gGYoDu798D53cWgzAstCgFXHgFpKgveb+BiGkmdyFNALG8wYifDamCZpfixy4naw0aTIMa1bNzeIBq1i7Ht0=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DM6PR10MB4266.namprd10.prod.outlook.com (2603:10b6:5:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Sat, 1 Apr
 2023 05:31:38 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::4982:18e8:90eb:9bb7]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::4982:18e8:90eb:9bb7%5]) with mapi id 15.20.6222.035; Sat, 1 Apr 2023
 05:31:38 +0000
Message-ID: <ce66a6b0-01e2-990a-326a-9730083a436e@oracle.com>
Date:   Sat, 1 Apr 2023 13:31:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/1] btrfs-progs: mkfs: Enforce 4k sectorsize by default
Content-Language: en-US
To:     Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Davide Cavalca <davide@cavalca.name>,
        Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
        Asahi Linux <asahi@lists.linux.dev>,
        Josef Bacik <josef@toxicpanda.com>, Neal Gompa <neal@gompa.dev>
References: <20230322221714.2702819-1-neal@gompa.dev>
 <20230322221714.2702819-2-neal@gompa.dev>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230322221714.2702819-2-neal@gompa.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0183.apcprd06.prod.outlook.com (2603:1096:4:1::15)
 To SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DM6PR10MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: 11be3481-d3b3-4895-1c72-08db32725dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0O+p9Jly1mE+z0pSXQ/k+8KhrzU48q5aJ4rbPjAWgILlbnkdm7KBLh/+1MgIKqaoQ8VBNQPe6MU3jI3+g7OBC/ArMXeUHczGO1qC2o3akdR5zdMGX9ZW7uGYdJlIWbvwLj+BDrJ+gY3dRJ6BKHvTUZNVN9LxAQh41MkZclEdU3mIJyREGrH4GRcs55+ZP+WlOZBjshkZigGEkQPoPEH9NYFoyh3Pg7in3hGeXoom887idU6HYva0Yz7tlw3/sJDuD+BbA0d9YX4URMPMHvYzJGCGwXyYph/u+IcpQ9eHJsTJkYVnHmWiMYyuICAMXsV2QT/BAEfqfHYCe/uBVYh7reKqd8BGXYY415wr7/SVhzWUZ624FbWnUY1ifb6NQesBqfAQYs6qafj3XBgRXI97cP4vL0kpo07PPD6B9o1K62nyT7S8YR6G+tc47UJhrahjmu3qwMmTTvEIs2zLtZ7aXA4ivMFpG4X7Asnal6x7AiNdY43Ui/ZtWx/YdJ70gH2HgpbYVuSZpcvv2sH6Mgw4CdheVQ9l+p+0FSJIGAUpZhuCjLyuKhoPI4Jo0yRbwWRkbkoUDaYmA1Lhn5yUPDM6cTghWY76DFGX5HhYPR8QzTB7AGfUjqF34uJ9G9/f5Hc2Va6SdpEFhj8M3abCOciw7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(83380400001)(2616005)(8936002)(5660300002)(38100700002)(86362001)(186003)(7416002)(6506007)(6512007)(6666004)(26005)(6486002)(31696002)(31686004)(40140700001)(53546011)(41300700001)(66476007)(66946007)(478600001)(44832011)(66556008)(4326008)(316002)(54906003)(110136005)(8676002)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vjg3b09zT1BWUkRNTHBGOWJxRllqTFhMZ1ZvaHpOSnJaOFJhVDJNU3dVS2Qr?=
 =?utf-8?B?UU5Xbk9EdmtIZWU0OHlhY0V2dU41YUMwS2w1WDY2WjJFRWd2bjkvbzJZWEU0?=
 =?utf-8?B?K0U0QStqV2JTRWdqMEsxNmxKNlU4dkk4c1VjN050NDJjb0F2MjRodXpyY0VK?=
 =?utf-8?B?UjloWjJTb1NsV25PVkpudGdQVmI2NVJQejV4RmVMbFZyZjFGVXk4QmdWR2N3?=
 =?utf-8?B?SVI3RzYxVW1penExYXpPZXpCMEZJTVVRZndkSUF4MDIrUjZUajd6WmoraDdt?=
 =?utf-8?B?ZUhmeG53RVMxT1oyb3V6cHZwQWp2anZvNTFFbGxMTU5EQWhhRmVrUThKQ1FH?=
 =?utf-8?B?ZG5sdlJnL0dxdUo5UnMzL3RCSkpzaW9TTDFGN1UvSDJIbDByVjlBd09WbkdS?=
 =?utf-8?B?ZmpiV25KTlNSK0Q1UXJPVDkxNFNjN1ltUFVNN0dwU0pudHBSTC9sS2IvbTU0?=
 =?utf-8?B?dCtYUytrQW9OYlVidkF6bFZDOHRIT3U3WDl3UnZja3ZUUXNDMDVid0xmR3RK?=
 =?utf-8?B?SWc0L1IzSWpWUGVDVG1lMk5EQ1RGWVk3SjRhYm9GbDFLYzEwTlhCb0ZGRWNz?=
 =?utf-8?B?VWRaVGgvQU1tQ2NYMC9JRytVVzh2QndlUUFpbDh6M1MxUkh2TFBTZ2MvamxP?=
 =?utf-8?B?SVFQbUNRbE95SFZzNkhZUTVFcEVla0hwQnIzN3l1VlVaVUVaVkJqMXFVUjUw?=
 =?utf-8?B?dDVHc2svYkpCTFUwSDh1SVZSeWJoWlp6UHN2NVRSak42amxXcW1yUVBhYTlB?=
 =?utf-8?B?Ymo4MTlaalpOVFdqM0Qxd2FVeDVYV2VpZWJuUWx4Wk51RGtMb2JidGNMZFN6?=
 =?utf-8?B?UjE2azBSbmlMVmRzTkVLNjZodEtqckFYNEhoTUdEcmxNL1hiV3RicENsblhH?=
 =?utf-8?B?TE9HSHg2TW00SzFvMCtJNysyZzI0N2tobEFLZkhWVjdDb3Nxd1hGc1VaUTc4?=
 =?utf-8?B?bUtBT1RoWVF3U0dnSXVCajhvTEYxZnZBdUY1RHpiN3dpRkVlVGtPVURFb1JQ?=
 =?utf-8?B?Y3FUK0Y3cEpXSTJRc0JMU1J5SDZva1lYcEFkRE5TTEdJTmhpRkpIaWJSdlZo?=
 =?utf-8?B?SmFFRXNkamlDZHdFWjBmNytuRXlaaUt3ZEZlUDYxODVRYk1RcVFYZTNnSVRK?=
 =?utf-8?B?WFN1UEhvQWdScS84Z0cxYWluNkhaZHFmV1BVTWJ6eWR6T2dWdkN3ajRwaHRT?=
 =?utf-8?B?QjY0ayt1aWFQRVc2MW44SE8vWEk4NHUzY05RVjdPZ0NjTFc2MlliK25SNG83?=
 =?utf-8?B?ajFYTkUzdVc0aWVRSlFCci9mM1hWOHd4MEtTWE5OZEdaTlJoNW5tendsWUJT?=
 =?utf-8?B?ZDF2TnhFeFljZzI4aDdVSW1GUUpNaG9TNnhQN1pjb3Y2MVNnQ2NIZTd6Nnhj?=
 =?utf-8?B?Z3pZUldEQ3RvL0lYb2oyTkN5ZURsdkdJQWpwYkZRQkdUTEVyWVh6YStKb256?=
 =?utf-8?B?SGxiclA1UFEwRXpIamhVN05tNXJJdzNiY01razNWajRSWHdsS2NvL2c2aWhm?=
 =?utf-8?B?aW0rZEdUTFkwdlZzWnd4QkxYa3oyTXdNUks4eEwyb0lRV0I5eHVyUEdUam53?=
 =?utf-8?B?ejRnaFpMZGJIc3ZKWUJRY2xoUU9ibHdvaThtVWZXT0RHSHoxMHlNZ2c2TFZm?=
 =?utf-8?B?Q2JhY1BNRkZaR2tkQTdsais5ZXRpK3lwUzRCTnNtQXNOalZKdi9iQU80YjVS?=
 =?utf-8?B?MXp5NlFidWFBN3o4OWF0U0UvZnljSjlhQXgvUlVLVk1wakR3YlBJRG5BVEpC?=
 =?utf-8?B?SGJwWVdDMmM4K0t6QnpJTS9GKzZ6NEJraGVHRGM2bm1XdnovTUdmKzdTYkNl?=
 =?utf-8?B?cm52V3NxRy9rMjk0b0t2NVYvVDlCTkpnb3N1VnlFOE8ycHFEVzRlaG12bnI1?=
 =?utf-8?B?THZscnJyb2JaTWJDTmZVZW9uWkc5eXY0V29YT1I2UkpXTGtzWVZsNStPZU5K?=
 =?utf-8?B?bi8yaXJLbHR3Rmp3cTIzNURkT1lENmhwUVJiSWVDMEJyQ290STV1MmsrZ2Zo?=
 =?utf-8?B?UWVSZGdlNkQ2TkdxWm84R0tUZFBSWmt5eVVoSk45RHF3Zjlha1hBWDlZZEl3?=
 =?utf-8?B?UUhTR092dENCN25CWWZkRWxSWCtNRlp6MUdYZnJoSG4xcGMwYkdxRGpVdHZR?=
 =?utf-8?Q?hVyPoPRVVNcJc+8DWkL6M1ssu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eGgrTWV0czFDRTFkYkVBVW5BaTFqODBOVUR3TTNtMTJJRmtXaFZOQ2xYVVdx?=
 =?utf-8?B?endzeW9EL2hzQ1dWOVltTnVTZFhnUk1JazI0akk3RDNzMy82VkNlNnpPOEph?=
 =?utf-8?B?Ris1MW5VNTBLUnQ5U0FKeVhFTXZwdWxwLytSQmlFM1ZPeHRDTmliZ3JSSm5q?=
 =?utf-8?B?YWhJUkNGV2NNSEdFUW1XOGJ5Q3lMeG1QeHZzQVlJZ3ZtK08vaWZkVU93cGQz?=
 =?utf-8?B?cXNSdXJBQXlvMVZDbStMK2pKKzY5clZWeGdMb3pFSnEvMVY4U2NCRnc0b2pZ?=
 =?utf-8?B?eEJWNStFdjJTRnl5MGlGRHVhOW9RbDJyVGVwdWkrN0FBMW1FR011QkVxT3FJ?=
 =?utf-8?B?M0QxM0RyL0tEcUVpalhpdWRzbU1TMmdkQVJlM1FCTXFrSmVMV3czNnNxaURl?=
 =?utf-8?B?Qlg2cGtRd1pEL1YydUJVL2xudWw5ZGgvTVp2OWsveW9MUm0zS2JKeWtOVXY1?=
 =?utf-8?B?NTZwNHczRmZ2THhvZWdrK2w0a2dHN0Q4ZEw2WmdSYjB4YnpCc0M2SFJ4V3ZL?=
 =?utf-8?B?c1ZJd1VJNHJkTTdZZzQ2YnljUlc0czJ1cUpVN1dkVTdGQkQzbmIrdGE3bE0r?=
 =?utf-8?B?dkRDZFpualhwdXRCTEJMaEsxK2ttVDRMYjhvRjVXNjA4TVBGUjFnM0JkRGhj?=
 =?utf-8?B?bHRUZU9Ya2JOclJRTTRTY1NZanluelU4dWZjdWZkV2xDbXRTMU5jQXlpRU1u?=
 =?utf-8?B?Rm1naUFYV3dFTndZaFJuTEZySnNVOW14azRrcWxNd0RtTS81WU4rLzZyanY0?=
 =?utf-8?B?RTZ6L00vc21DOWQ1QW95dTRNbnhEK216MUpiSHBMUzdMYnJ3Vk9MUjRsSy9x?=
 =?utf-8?B?ZjNSYVhxbGt2QkVKdWN4SmVOK0thNElkbHAxV1E1TDF5ZGplbmE4U3VOMVlK?=
 =?utf-8?B?SWU3dXBUeUpDVVg5M0lvdUpSZkN3NG83K3NoTlYrZlNkeTJ1MHB1ekt2YVE1?=
 =?utf-8?B?amIzdzVra0JCbE8reVRBNHlXbURLUDFzMy90NTdibDI1MHEyQlpkbjJHT0NP?=
 =?utf-8?B?SGpsZEMzSkp6WndtdDFMT2grNHgzOTF6Y2FwTWNWRDRlUGdYaExCdXA2cWJy?=
 =?utf-8?B?TjFyN3JlVlhxRWRENTl4Unp1OGhCeDhSODlEWmQ4V0RYelZzQnQwTmlmKzJK?=
 =?utf-8?B?ZEdEck0xYllsZlRSUms0SWFySzZDdmI3WHBWWC90amN4bksrdGZDNklkazFk?=
 =?utf-8?B?R2p0VDlJZTB0OWtiSXZnY1BwUjBVUWlDSHA4eHViUVFZaFVObGVTa2IzK1c2?=
 =?utf-8?B?bGI2SkFGbjdnZFltOHl0SXQ3WW8vT00wRThQYzFSbDJlZ2lGSEpGTDR2NkFn?=
 =?utf-8?B?Kzh6ZWZVcDJwMXkyVEFTeHVjM0NHU2ZWYXNLbVMzS0VlWSsxUjBablJJV215?=
 =?utf-8?B?U3I0bGtmdVp0UDg3cUxrT2J1WkZqS0NKR2hUdG5JeDE5a3RnT0lUZVFUeUlJ?=
 =?utf-8?B?dWpPQWxlT3dBb2RWa2NYOUtFaXc0NUd3UEZ5dVl3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11be3481-d3b3-4895-1c72-08db32725dcb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 05:31:38.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zAYA9okKocm42b/QKFhan62OfQfP8dTxe6SZQY+Klktcs6lGxx3atWLjhRka+H2cQWXORgAJSl4acSdCTvJjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304010048
X-Proofpoint-GUID: r7o0vT4Wa09BFTEGDjo8I2W5vDULa2Fw
X-Proofpoint-ORIG-GUID: r7o0vT4Wa09BFTEGDjo8I2W5vDULa2Fw
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


[ fixed table format ]

Comparing btrfs sectorsize=64K with sectorsize=4K on an aarch64
virtual host with PAGESIZE=64k shows that switching to sectorsize
(ss) =4K by default for buffered IO has a low impact, while the
direct IO performance is improved by roughly 21% to 152% for
various fio block sizes as shown below.


aarch64 PAGESIZE=64K
====================

Buffered IO:
===========

FIO bs  ss=64k ss=4k   diff
K       MB/s   MB/s    %
4        752    755
8        783    832    +6
64      1066   1173    +10
128     1120   1098    +2
256     1112   1079    -3


Dierct IO:
=========

FIO bs ss=64k  ss=4k  diff
K      MB/s    MB/s   %
4       54      106   +96
8      107      270   +152
64     737      894   +21
128    862     1130   +31
256    846     1103   +30


FIO config file:

[global]
directory=/mnt/scratch
allrandrepeat=1
readwrite=readwrite
ioengine=io_uring
iodepth=256
end_fsync=1
fallocate=none
group_reporting
gtod_reduce=1
numjobs=8
size=10G
stonewall

[fio-direct-4k]
direct=1 <-- changed as appropriate
bs=4k    <---changed as appropriate



On 23/03/2023 06:17, Neal Gompa wrote:
> We have had working subpage support in Btrfs for many cycles now.
> Generally, we do not want people creating filesystems by default
> with non-4k sectorsizes since it creates portability problems.
> 
> Signed-off-by: Neal Gompa <neal@gompa.dev>
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> ---
>   Documentation/Subpage.rst    | 15 ++++++++-------
>   Documentation/mkfs.btrfs.rst | 13 +++++++++----
>   mkfs/main.c                  |  2 +-
>   3 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
> index 21a495d5..39ef7d6d 100644
> --- a/Documentation/Subpage.rst
> +++ b/Documentation/Subpage.rst
> @@ -9,17 +9,18 @@ to the exactly same size of the block and page. On x86_64 this is typically
>   pages, like 64KiB on 64bit ARM or PowerPC. This means filesystems created
>   with 64KiB sector size cannot be mounted on a system with 4KiB page size.
>   
> -While with subpage support, systems with 64KiB page size can create (still needs
> -"-s 4k" option for mkfs.btrfs) and mount filesystems with 4KiB sectorsize,
> -allowing us to push 4KiB sectorsize as default sectorsize for all platforms in the
> -near future.
> +Since v6.3, filesystems are created with a 4KiB sectorsize by default,
> +though it remains possible to create filesystems with other page sizes
> +(such as 64KiB with the "-s 64k" option for mkfs.btrfs). This ensures that
> +new filesystems are compatible across other architecture variants using
> +larger page sizes.
>   
>   Requirements, limitations
>   -------------------------
>   
> -The initial subpage support has been added in v5.15, although it's still
> -considered as experimental at the time of writing (v5.18), most features are
> -already working without problems.
> +The initial subpage support has been added in v5.15. Most features are
> +already working without problems. Subpage support is used by default
> +for systems with a non-4KiB page size since v6.3.
>   
>   End users can mount filesystems with 4KiB sectorsize and do their usual
>   workload, while should not notice any obvious change, as long as the initial
> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index ba7227b3..16abf0ca 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -116,10 +116,15 @@ OPTIONS
>   -s|--sectorsize <size>
>           Specify the sectorsize, the minimum data block allocation unit.
>   
> -        The default value is the page size and is autodetected. If the sectorsize
> -        differs from the page size, the created filesystem may not be mountable by the
> -        running kernel. Therefore it is not recommended to use this option unless you
> -        are going to mount it on a system with the appropriate page size.
> +        By default, the value is 4KiB, but it can be manually set to match the
> +        system page size. However, if the sector size is different from the page
> +        size, the resulting filesystem may not be mountable by the current
> +        kernel, apart from the default 4KiB. Hence, using this option is not
> +        advised unless you intend to mount it on a system with the suitable
> +        page size.
> +
> +        .. note::
> +                Versions prior to 6.3 set the sectorsize matching to the page size.
>   
>   -L|--label <string>
>           Specify a label for the filesystem. The *string* should be less than 256
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f5e34cbd..5e1834d7 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1207,7 +1207,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>   
>   	if (!sectorsize)
> -		sectorsize = (u32)sysconf(_SC_PAGESIZE);
> +		sectorsize = (u32)SZ_4K;
>   	if (btrfs_check_sectorsize(sectorsize))
>   		goto error;
>   

