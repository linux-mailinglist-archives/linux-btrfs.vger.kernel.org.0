Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541874C63E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 08:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbiB1HpP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 02:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiB1HpO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 02:45:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D4F66AFA
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 23:44:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21S6diaq021511;
        Mon, 28 Feb 2022 07:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WQ6PP6uvHovN5gWXA+DeEK33lOmfvfngRJgsyLnoBjg=;
 b=CPs1KLIyOLoBtq+9AxdWE43VwWd1ANn1jZOsV4fbo1sG0uccpBG+0/AblC3/ZN5hW2sP
 nBPIYmShf16s2zGb8ggXI7+ecN/vTcNejg8BQn/RdC/dtZKYsclS/y7CziWPdnf6I2qW
 iQYe9PZDXE/2xSdmldAKbBnuVqhqlQYLGtci5JvrZ+/HKXrocQNeNmVlxKom6thrf5kg
 E6khtETK1p195CqRRIBtgZq6CNsrWI7rfu4r4e3HlyKPabD5/iYh4clipQmcPgpOQSoR
 yvLfbC2erFuPprGT8CjC+mpT80GD1toML3f/i2bnuaOPlNmUe1VupqTCqNgu5kuzpfBZ iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1ud8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 07:44:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S7Zre3054463;
        Mon, 28 Feb 2022 07:44:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3ef9av1sev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 07:44:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7Mp9IAQ5wWOG5v0SsBP0hLT966ELKtzK853ndoTcmeuKP+F9zQ6q88YnrgT18K9e/cFwGYbh9w1O3iWC35hrOXMUewT7SXzywCj8aPhAwwp/ncLQT6yxPsD9rO/0su52XYisekSbM4iBm2d/6jaLOSoum3rXoq27mVQcA3jLluleBzzc3/HgU8RGr8SuZTqDN+zvkFnVuwDHMIfhnsexPpWCY3ZpD9ZevzmmZQc69tyZdiP+jAD4DQ9GTWX5UgyFOD2itNyzykIIVyCzyy4+oi7ZN0oqt81FM9wNHI9k42/TNnwBsOQJWqsK2etX7JfEqLAKl8gNtauGjtXIz994g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ6PP6uvHovN5gWXA+DeEK33lOmfvfngRJgsyLnoBjg=;
 b=Ww1tySrl4NAq1WYkz2UoeuziFMoz8A0qWPPnB32FLNia/3FeoVQUTB4JIVA/HKu3x6RbwmufZR1Ohoa1MgQSHjchr84T1MJclw1F4iaASSxKqIVqHj7KRenRXCUzCtsBVqhU6drpaVtZD3gmZ2D0zXqDTUCu9HqbxulJfjK1cf/Q+pR64CoPm9WA7DYZOTLkpDJhf+r1Vt4vADlM5lIrfKij0f5W/u/dI9XnhPqSM+OqR5asMHSM8NTAN6pYwXqBRltUkSSTXadTGceRj3m7HVPt3eAcKH6B1BBQm8IClhHkkyntN1QF14+vjeBZqu9cUQY7vn1ngiWS8toe8Emgcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ6PP6uvHovN5gWXA+DeEK33lOmfvfngRJgsyLnoBjg=;
 b=d1u+docJ0CPZmtOKw7I3p+lfcve/6aEp3OQNHPMqCBMEMDIMDbxKyqk/GZqX1rN5tkOpImlDeXJhuogE5a8AxKUZZB0DlQX1W82mDYi4rlAt5PIZN+MCdE9cCeqAQv70VMUJJKF/lkevxSoJEDp5cRB1Fg8BtJfd+pOVXd+XBbw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 07:44:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 07:44:24 +0000
Message-ID: <905b1a41-88f5-c653-81f6-5db5f56cbe6f@oracle.com>
Date:   Mon, 28 Feb 2022 15:44:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>, linux-btrfs@vger.kernel.org
References: <ad2279d1be9457b5b0a7dc883f7733666abb1ef8.1646005849.git.wqu@suse.com>
 <264cfb18-70ed-c20f-ba28-3fad002ed645@oracle.com>
 <75c0e9c7-165f-3a4a-dda1-ebd0cc092392@gmx.com>
 <7d7dcef9-93c0-59f9-b553-f15b6a443f0f@oracle.com>
 <2ea80755-05ce-251e-bf5c-0abc9b0da45f@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <2ea80755-05ce-251e-bf5c-0abc9b0da45f@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb43f68c-d947-413e-f8a0-08d9fa8e23d7
X-MS-TrafficTypeDiagnostic: DS7PR10MB4832:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB48323C006FD5FD6F82108DCBE5019@DS7PR10MB4832.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhx93IuW9VutYmKX5u90f/rLHGQ2LSVb9VuhbZJ/wLaO1fH5cWA8Sz6UblBxZ2HxD5Ayzj2/RJy08qAXAC5iMVZzf1hkZJgUnMGKTZGpdTMkXZH4FydPUyyeoR6pwSNduqiK9q3Hix/D4Zg4tHlmyHybIfdNjudb4xXSqKIALErLpYDzzG4+RW26yBlJK+6S7GIsOqJguufm0T27ssCmuexA40MWp26dFwUsnvknO1SLhYU0Pi1wdPIF8GT9AQ+R3U5DtFhyh1Ufvp073B8dShXssnmDFT0cyIt4BCtBOoBOwix6aXkM+zDWHhZujPATzCc0o8DIGuOlEtp9OqYC7zsQosTeFvyhhfjJrcvZafLtlycI+pXX0giKJjoHEw/evcyPLG+2VVIey8qZIzSApHlmSsBG3l6lEaPPXgjZjBE9isXG38jmFzcMW68zWge9ASzFv0L8u6ZO0NI/05VP/YEATOz8dh602WM276eWG0oiQVZcizl73AxzmEaYQGX6isNHeAxF90yvDHQiNRInb2PehAxj4nclneGfJAqOLcBvUOWGzQoO6Mf0HxXibButfvkQRKj62E05vA/rSNBKSrwQJRywMBcvqiAfxi4izf5gmFjmP4kqslVgeVPvORL9Uo4Jq1O+znRc2jt8t+4AvABEDaNvcANfEJrRws30YUmRGNMl9nU1+zmDePSSadYUx6nmpfXLTWiyBTQ/oAewV5Qd1Ipu/3PH4us+fb6QEmMrKmW7Altbt9gA2wtySSa75tDaF/eqlAiUl7a4hDs2/uN4ZrtANSyb4hH7Dhwr4CaRgRueLgc33PIW8XDFR0ai
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66574015)(44832011)(38100700002)(8936002)(86362001)(5660300002)(31696002)(4326008)(2906002)(110136005)(316002)(66556008)(66946007)(66476007)(6506007)(53546011)(6512007)(8676002)(6666004)(36756003)(26005)(2616005)(966005)(83380400001)(186003)(6486002)(508600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlEc3lqai9icXYyaUZYMlNLOUNKMUNIc1hMMlpPa0h5dU5tclJTaVlLSHlS?=
 =?utf-8?B?NHBEQll0aGxveWlYVkFWQjF4TUgyaU1POU9XYlNjK1NXRTFjZ1RDTmgzek1y?=
 =?utf-8?B?OU9VdGJSM2F2ZUI0TnRyMjNzZTl2WnIrMUt5UkI3UkN5cFM4NXJ0YTl6aEZk?=
 =?utf-8?B?NllZZlBva2l0UENZQkhPQXlGZ3NQRkdYTlo1S1c1RmNQYmlsclFveU95cnBN?=
 =?utf-8?B?SUdWbmVJc0phYXBCYWR0amRKRlh6MnJZUjgrdnk0bDkwalcwUTNpMHA0NEZv?=
 =?utf-8?B?bGI1VmwrbWJjdnRkSzMzZnZtWis4R3Y1UDNROU5qWVZHc2RSdm9hLzU0bk9n?=
 =?utf-8?B?RVZsVHZCWnpwQzI3WlBmSDJ3ZE1WTWlNRk1SSDZsako2bUdlajh0OGR5bjdn?=
 =?utf-8?B?a2ZmQVhEYmx5TUl4TUlGbVNzQmw5THhZdVpDS2NXOHpxdjY3TGFqUzN4cDY3?=
 =?utf-8?B?U3kzakg2bFNzR25PaENCbzZwTUpOMVpJdllNelQ5V0J3MjBBUUVybzByMVFQ?=
 =?utf-8?B?U01UVjNDN3lkYWQyUkRMTHh6Y1FySU9FU2FYUUs5R2hDaWhQeG91QWdIcnNa?=
 =?utf-8?B?YWhxRXJUeXYrbk9SS05vMWVJOFU3UDRtYlJlN01NMTlIV3BGajVOMzVsbkVT?=
 =?utf-8?B?NHFleG8xT2ZhMDZwK2tSemtieThwM0FlQlorekJ0ekNHbVBtM01SWHQzUmpK?=
 =?utf-8?B?R05Nd2dzeUduTm9RTTc5cERDN0Y2T1l4QWZ6eWZBcmFDUWJVMjZsTU0zNXVq?=
 =?utf-8?B?R25xekMyL21jdEFhRDZzeS9hU0tWWUVpU1lYMkJ5Vm14NDY3SXEvOTQ1Ry9K?=
 =?utf-8?B?QUJvNVJmbFREczlYN2liSjhRMlhkUmJtNXlEWjgraExlSHh3QTdQY2xKZ0pK?=
 =?utf-8?B?ZjNBVXBBbUg4TzJ6bENVY0UwNUpWOXVBMUFGUCswYVgzcnBxRitQdHYrbEVD?=
 =?utf-8?B?OHl3cDFJOThIdCtYaXpKV1hIcHA5NE1jb2VKZjludnJIYUhOZGY3eW5xcVJ4?=
 =?utf-8?B?MG9FSms1S3FVS05BSk5kbkxhekk3YXNVSFVMcjJLY2ZqM2tWck9weWVoOWcx?=
 =?utf-8?B?Y3dXVUxRZFZ4VFpNRy9WSzVTYjlRM3pqUWZBYlh6T1dBOXUzczN4bUZLRVJx?=
 =?utf-8?B?ZHRtMEpxbGdiSjZqQWhMR1BwYlhXK2RjcjZOL3ovVWkrcm5qaFd2K05CRDVm?=
 =?utf-8?B?dVZ6SUNIN2J2U1hKeTNLYnNwZ24vemZPbDFQU2tla2o1dXdPYkRiMDBDUjFG?=
 =?utf-8?B?QTU3enNsY1F4QU5TTGtUTXZTRjVXbjFJOXZ0enJ3em5ySktOZVdGUWZsVmNO?=
 =?utf-8?B?LzJaWUtFSUpDdmJFamRjTVZuM0lvbC9LUXZ2MVhhZGxIQUhkZ0JCbEhBSkZV?=
 =?utf-8?B?WTllc0hIN0pwUkNLc3VVUnFWNEE2N3ZZSm5Ga0Qxc1dZYWlzd28veDV3Ym1C?=
 =?utf-8?B?VnY4MnFuRWw2eUhhNDNSWTVtRmdlSFhaVy9sQ2N1TC9nd254NUtoMVJPWCs0?=
 =?utf-8?B?M2xhZ2FpdkZDZDUrWDFmT3ViZ0p1UnFJTkE2V0x6NDdOb1VPMGNxYkFNL1Bp?=
 =?utf-8?B?WnZRRFEvZjU3dVJpR3ZwWnc0ekhTb0hnbHArTHhwQk02dFlWUi9MTVBBWW9h?=
 =?utf-8?B?RzBvOHlNWHhyeGtGSHVwM1ZPcW5tTi9PbjV5QXE4aVBCRHhLbFEvRUdZdDdp?=
 =?utf-8?B?bTlNOFpMNE9oQlBkclFtQzRGSGw4WGFpYmNSTTJqY2dCRzM4YVQxQzQxbnlX?=
 =?utf-8?B?UjQ2a3U1RVZ0aDRyazFnNWZKQVFpRHRmMmJMOXpCSHZoOU1rajJBZk0rU1pi?=
 =?utf-8?B?a3VacXEwMjZQVXBMNWxNcjdlU3F2ZmVnWVU1S0lkUnJlWU1vTUhYMHJIeFZy?=
 =?utf-8?B?bnl5aEVKdHhjMlRGbU5vY015UERVd1Vpb1RQcExEK0Yvc2x5UkFNZUxwd1dP?=
 =?utf-8?B?MTRXcW1QSnBWbEUyd0U1U1J6K1g4YUFNcG1qSUJnNlZwUXEva2pvbTJUQ09J?=
 =?utf-8?B?UFFkZGVjcjg2MzMyejdWaXMrTVEyZzhXNVUxNUEyTTJIVW52L1h0K0N4MDNh?=
 =?utf-8?B?YTFVSTNyd0ZFS0k2SE8rSDVNSTdoRDFsci9lUkk5enF2c0c3NTRJVVFYejNM?=
 =?utf-8?B?cFZnUUlJMWtoK01pMzdTMjN5eXJYQjRBNjZmSkVCeEl4aEwxWTRVRVJmVVlN?=
 =?utf-8?Q?92XfFDE9jtRzPE/v1Kb49mE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb43f68c-d947-413e-f8a0-08d9fa8e23d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 07:44:24.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8x3vk+b3+DO6o2NHnV3y/nnyWz9GVNgQi7KM/pvZ65D+IB+NfkIu8DtI4U619ZjPrtWXgJDzZ+GzfTpDZwZIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280043
X-Proofpoint-GUID: -NaVx-orxY9-q9YpPLZeCmFXi9Su7CML
X-Proofpoint-ORIG-GUID: -NaVx-orxY9-q9YpPLZeCmFXi9Su7CML
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/02/2022 14:33, Qu Wenruo wrote:
> 
> 
> On 2022/2/28 13:49, Anand Jain wrote:
>> On 28/02/2022 11:17, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/28 11:08, Anand Jain wrote:
>>>> On 28/02/2022 07:51, Qu Wenruo wrote:
>>>>> [BUG]
>>>>> There is a report that a btrfs has a bad super block num devices.
>>>>>
>>>>> This makes btrfs to reject the fs completely.
>>>>>
>>>>
>>>>> [CAUSE]
>>>>> It's pretty straightforward, if super_num_devices doesn't match the
>>>>> deviecs we found in chunk tree, there must be some wrong with the fs
>>>>> thus we can reject the fs.
>>>>>
>>>>> But on the other hand, super_num_devices is not determinant counter,
>>>>> especially when we already have a correct counter after iterating the
>>>>> chunk tree.
>>>>
>>>> Cause analysis is incomplete, given that SB write is the last. The root
>>>> (and thus chunk tree) and super_num_devices will be consistent always.
>>>> Do we know how the miss-match happened?
>>>
>>> Sorry, I should provide a full analyse on this.
>>>
>>> In fact there is a window in device remove path that we first remove
>>> device item in chunk tree, and COMMIT transaction, then decrease the
>>> device counter (without commit transaction immediately).
>>>
>>> In fact, there is already a TODO comment in btrfs_rm_dev_item() call
>>> inside btrfs_rm_device() saying exactly the same thing.
>>>
>>> Thus if we got a power loss/reboot, like what the reporter is doing, it
>>> will cause such mismatch.
>>
>>
>> If sb write commit failed. Why isn't root read from the superblock
>> pointing to the old chunk tree with 3device items?
> 
> The failed trans is not the trans committed in btrfs_rm_dev_item().

Ah. I got it. So why not fix the TODO instead of fixing debris due to
missed write?


>> Thanks, Anand
>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Thanks, Anand
>>>>
>>>>
>>>>> [FIX]
>>>>> Make the super_num_devices check less strict, converting it from a 
>>>>> hard
>>>>> error to a warning, and reset the value to a correct one for the 
>>>>> current
>>>>> or next transaction commitment.
>>>>>
>>>>> Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
>>>>> Link:
>>>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/ 
>>>>>
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>>   fs/btrfs/volumes.c | 8 ++++----
>>>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>> index 74c8024d8f96..d0ba3ff21920 100644
>>>>> --- a/fs/btrfs/volumes.c
>>>>> +++ b/fs/btrfs/volumes.c
>>>>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info
>>>>> *fs_info)
>>>>>        * do another round of validation checks.
>>>>>        */
>>>>>       if (total_dev != fs_info->fs_devices->total_devices) {
>>>>> -        btrfs_err(fs_info,
>>>>> -       "super_num_devices %llu mismatch with num_devices %llu found
>>>>> here",
>>>>> +        btrfs_warn(fs_info,
>>>>> +       "super_num_devices %llu mismatch with num_devices %llu found
>>>>> here, will be repaired on next transaction commitment",
>>>>>                 btrfs_super_num_devices(fs_info->super_copy),
>>>>>                 total_dev);
>>>>> -        ret = -EINVAL;
>>>>> -        goto error;
>>>>> +        fs_info->fs_devices->total_devices = total_dev;
>>>>> +        btrfs_set_super_num_devices(fs_info->super_copy, total_dev);
>>>>>       }
>>>>>       if (btrfs_super_total_bytes(fs_info->super_copy) <
>>>>>           fs_info->fs_devices->total_rw_bytes) {
>>>>
>>
> 
