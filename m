Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85723FE364
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 21:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhIATuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 15:50:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47536 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230353AbhIATuu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 15:50:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181I48ig025816;
        Wed, 1 Sep 2021 19:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YQihaimy19oPv9mlBDupkKTp0g1Stbt4POV8kaognlc=;
 b=Us0bkSrPyNc2tQr1cm55Lxt3En1EKqteZwaKpPhK3gNlsgshLT+3gEU8co5lt79n3Y8n
 VVcYWu+ZTG8Zwu0B+fp/TbZoc778JRqEauEITryDkdWW/oQFJUj2shBUKr/cZe1dNiGb
 PJhK2eTWKAwN0gRax1mMzbDrthi50ZIcecgJUTPY45tZ8Q/tZvJnzq0zFRnos0j5R0j8
 FjY5+rffG0VHPGIO3u5hZ6Yuab7iu/0gztAaVw/gCgz9V3CeRwLc5xlxI9Z3M5F6l/Gy
 6mKBORjvJswhPePvXQDcvW+rDTu+umTgz/3jdpMv2ikVJdMvCb3s+dyf6Asxy5g8tRad 1Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=YQihaimy19oPv9mlBDupkKTp0g1Stbt4POV8kaognlc=;
 b=LD6SXSJazf3bjNR0PrLT8RYy0KzbZ4qNstSQse2OWYcZnqSFqZ40P8UXb6hIIeAilgcM
 cFfXbAc6MiXH0xoQDlaSfhqU4k7NBABLgx0b3SJK24gT/1phTK+YXZ1ulbinlkw34o2T
 zt6Sq/z1PuUtIFFnXnXVPZ8mbOhScYBX9aI8TKTIa6z5DMd7qouywbdh680Uh6i67rJ7
 huhDVL14Qm+V6tan/6cddO3mfLWlZxU6fvHLZJ3PLka6tNK0QPMfBCAGTOfr6qabstUG
 HzJkoqFX09WBdtQh37Yc9JrdXyCch7WkuRzRDjhz6zKRnd5e5zFMCvPP2Zqf4JujZnQH WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw58c7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 19:49:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181JjerB006542;
        Wed, 1 Sep 2021 19:49:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3atdyudhe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 19:49:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8rO893d84spgy9W9Y+rYpKlfNqKYhbl/RsGRJpJMOqQUegqA+A05VZ9VvmlifoJyOhiiuA8ZwZYTd31SNLMFBsZu6SngrtYGIV1chnmEUlWv5yjUmdDIvSqzSTgPp2nSOz+BC/fze9woCOMTUTmFX9vXliZu5Yeaz/ZYMjUijfGU2ij5MUEs9szO4wTTBIqk+xGIhmR4A0bb5XiHkF5HFcK+uFaiKv2wr1pU1ToBo35YCdE8F3g1kMeTKTN4Co9NApYNryaTs9hr8uSAPhcROPMgt9yLFFenAD1yme95CgLl1MpIUDWjBZhKix0MlFxd1IxZMTiy5N4sJrt7Hwn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YQihaimy19oPv9mlBDupkKTp0g1Stbt4POV8kaognlc=;
 b=ZCr+6kOrRZNc8p3WWJ3kyThX/jDkgeJRE2OuLvKnCEFDUCGOzuMA5lpMjhYadp+/FVTbeaHlUCNJATdiCnq3qSoWcdnyJQvy+L/EJvT82RhCsHcBIFBRBnDDFqJxPHf1FywPY9CLkvdB0aq+eViZydzSAS2jkiKfv9OjZc3QzVPr2GC+RBoKncZaG4XB5LVB7tzJAO2AkCTxtP8iGm2+c6Wmzmw9Aw0w4W0pfEJt/Z2MMdEiNWbQt6lTfjQAATmqA6KGDBoGZnEV8TGT6YFSxeneGLvFFl+H+/vqPQoTi0/nli8d1pMaz0nrvRho5/ERgM0tYnXIzVZXqc+l/eKeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQihaimy19oPv9mlBDupkKTp0g1Stbt4POV8kaognlc=;
 b=kuFpPmn2GDWC/uaf0QG1Y4eP3lK3AFY4abb+wj6kNtw3EKZqdnwHQsaI2MWw8d2yEBhwLPoR8XlcxnCrA64SiEwklP2PbMNnmFEW4eI/lM5LdQ0MPiai7Y88idPMfAC7z6eBNlMk1Uksqr3Jj8Ic6mLOUZZIwKaHVSXvdgLzvno=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 19:49:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 19:49:45 +0000
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <495dbc7e-dd93-e43a-3af1-6597f35d38e8@oracle.com>
 <4c913c5a-7cde-7339-69b7-64908c7e1e7a@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>
Message-ID: <96ffa708-adfc-83c0-bd64-6af8926b372d@oracle.com>
Date:   Thu, 2 Sep 2021 03:49:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <4c913c5a-7cde-7339-69b7-64908c7e1e7a@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0178.apcprd04.prod.outlook.com (2603:1096:4:14::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 19:49:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a59dbf63-8952-451a-f917-08d96d81a5ac
X-MS-TrafficTypeDiagnostic: BLAPR10MB5186:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5186C55D99404BA6418DFFC8E5CD9@BLAPR10MB5186.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShckGT5w7KVxwDPUDCOJJlwuwkrwn2qkZZjIdVjYfByONk23ivinsfHgtRqilx9SsYHIj9isxAEAPvD6BVAWDSiA7O8j5I+8wQT36PKtIN4GWxkXBlnz+OtfPFmzeIMH57R6vTezIZiUONyX1hFpQTLDZuQghBXKYMxawKOq/SV+z99q8M0RN1E8CzzF3dkgfCBU6m+2na1VWlZH6kFbn6joH8LtQXfOMPGbV1TlHthwxJ06IDsvFISFbSCCqmSWk50Y4ooS8eHspQDcwIJOqA/gE40UYrZEnEybhAtipSnVmr+iPNgDKfSRNXqcB/svnRSqhP+yBxIbZzEoPKsXl4DeK7DochI0WrLjtRTWeFecJRJsbCo0XwezO2km212NWAH3c2LJCeKrBkxj8EGpyJSuNabUsWO4NVB4ADWXW4Zy7SFQbb/hFb8Dh0EjygpV8F7DFopTzOyju9A0g5Y/7vFigAzucbPOLMOteu+MzcXU+cpbl8rdRIZ1CmZgEno8x9UpHKCmZtMyhSfsXxJPogqIQYG0azW8nLdVeTcwCrc3wWWBr0xCmj20j9TV8AtVGvacibruYUPXJxpAoCMl7/3wtCDUWZFof7CLG4biFBRmf6x64QR9m8gqxNUgReArXXwzuSNBuQKLpA33NosefVwi0uH3iZr/qJfZ+RpYzKFQ24eckbaM/AEKPCL4nR1zRJY4PGgitWnQuEVPO0+4UG5ryEjcxI4LY1WZNKZyuBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(346002)(366004)(396003)(31686004)(2906002)(6666004)(186003)(4326008)(8676002)(86362001)(478600001)(2616005)(16576012)(316002)(36756003)(83380400001)(31696002)(8936002)(956004)(66946007)(26005)(66556008)(6486002)(66476007)(44832011)(38100700002)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDY0dUhZTzhwWnZNWUFUVmNmMnNUS2VLa0xlbjhaeE84VUhXZHV6OWZlT1BM?=
 =?utf-8?B?YndIdnpaNmgvOVhQUERvWkRxVE1oL2prU3BIbGNnZllwYWIrVmc3cVI4T0RL?=
 =?utf-8?B?S05qWXFmWFY5MEZ0YzNGbFVJVHREVHZjdlBVN1JocWRtUVpvSG0xNUlGQndK?=
 =?utf-8?B?d1R0SUZMYk52ZHhsbG9zR1lmV29XRzZPVzVvYmEzR2ZBN0JOK3FMTm1HOWtR?=
 =?utf-8?B?bjVsa05DWFk2RFh4UmVkRUREaW9TRE9jVlJPNFZ6NjVuUms2VWZFbXBqcWtE?=
 =?utf-8?B?R3FWRER1TE9IdHdqbnlpeUxMdkN5SlFKUDRJb3BPVTdCcENwL1E3ZzlQNElV?=
 =?utf-8?B?WmlBMkJpMGtaTEU0dlZib3IyREFxVGtsdmxFM2NnZTVXK0RnWDRlVCtDaFJl?=
 =?utf-8?B?VnJqVnZrUE83VzFMRStTaCtOZUlMclhJb1RPVlNiVkNrczYzU2VseVk0aUZE?=
 =?utf-8?B?RnR5bFFtTVZaWGdHK2p6dnNDT3BZV2FnZWR6ZkFRVDVSa0puZ01jZnZmSlg4?=
 =?utf-8?B?QkFmNUxVaVgzYUo0Z0pHMWp5bjQyVllaTlVoZVd2V2ZpaVZLWXhsYmd3b2hQ?=
 =?utf-8?B?UkxTTGNLVitGelFsUEFCQmIzdWZ6c0hSMDhueVlQbDZGN3NxZU83TitWc0tI?=
 =?utf-8?B?VWNvRDVxanUxRTI0T29JNFRNK3o3dEZ3ZjduQW5pdXZ0cThvZWRNQmJwck91?=
 =?utf-8?B?Q0U4WWxlQ0p6bW9GMXdNVnIrMHNFWnE1UlZOZjhqNzhkT2JZemhzeElSb0ZJ?=
 =?utf-8?B?WE43UjZaTWJKc04zMmhqWnZzL0Z4dVRjem0yUmYreW9HUS9meDhuWUVoa0ND?=
 =?utf-8?B?QmhIUTFjNWpBaDV1TEQrWGtNRHB5KzkveEw5eWkrdFlCcGhMVVoySEJtSytV?=
 =?utf-8?B?MGFJL0xoWFJJajBOdVN4M3pRUThlWjkyNjA1Mnc0Q1QyVnozZ3Fibit1Z2Mv?=
 =?utf-8?B?alc0ZitxRWFyTkdpY2ZrSlNsYURwWXFLdzVLTGZhOFhlZ25XUXN0THpzQWcw?=
 =?utf-8?B?TVg4TTM5Q1p0bkRYdFZ1Zk1Tb0Q2eFV2Y0hVaWFzb3pyRGgzT1ZHNWtubEZZ?=
 =?utf-8?B?dk5jQjREV2RiME93R1laRWVNeHROcnhxVmRIQ2s4WVU1Nk93U2gvWDA0eHJ4?=
 =?utf-8?B?ckR0cFFUcFFvb0ZBenR5dkdXQXhneDlwcnVTb2FLL3ZiZ2FGTDVVTnoxeTM1?=
 =?utf-8?B?b0dzdSs5Q0dTdFJyUnFxbjVPMXI5Z2FkU3lLZkF0dmx6UDlFZFo0M3luU2dt?=
 =?utf-8?B?T3hnZEdCdk1lckJXMG4vWDN4K3dwNFBhNXA4RGNDbWF6dk5QWk1lVXlIa25v?=
 =?utf-8?B?bk8yUXRWTG5TN1NnYzVjbXFQcHBwcm9wY2lpbEFkQXB0Y1k3Ly8vTlBhTzVY?=
 =?utf-8?B?YWJsaUpQbW5ETVh3ZWdqZE52WGRHUmRsaGdBNUsvYy9DZklhSUFQcVg1T3lY?=
 =?utf-8?B?OTh3elJTQkxaWnVvVDZDMi9nVWhmeHozYkJzNUxuWE1PTStYRG1Gdm1qQkVk?=
 =?utf-8?B?MEp0aTZqcGw0TTBtM0JvVDFhRERkODduUG1md0JmZHhEeDVoTkJQYnFLWGp2?=
 =?utf-8?B?a004TzZNOXZNcmpYOWF0Q0I0b2RId2g4ZjBJTFhJMHY2ZCtOK0xBM3psUmFQ?=
 =?utf-8?B?WXh0ZFMrMHY2UkFZbktBSyttNjdoRUhUS2JVN0dJWXo2U2NBcnlIRGhEY2ZF?=
 =?utf-8?B?d0F5UThObFl1OXhVc1pvK2lHNGJQbUttSHVmeTVnWGFrUVMxQkNYTGxJU21s?=
 =?utf-8?Q?4D6PTQD5m8JEId+J70ka8TAZHJkjDhgbPH+IrWX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59dbf63-8952-451a-f917-08d96d81a5ac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 19:49:44.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugOhhPRyTHPN7Zv3vZf1/GYl0AkPuFmqxOj5jEl7Lwy/KR7ODUdcjDY2lRHKm7sLYG7M9dccKXOJR7238Rov1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010114
X-Proofpoint-GUID: 0OfDV8vJFTLCEmzTfpjbdx9h0qmrb7Wk
X-Proofpoint-ORIG-GUID: 0OfDV8vJFTLCEmzTfpjbdx9h0qmrb7Wk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 02/09/2021 01:10, Josef Bacik wrote:
> On 9/1/21 8:01 AM, Anand Jain wrote:
>> On 28/07/2021 05:01, Josef Bacik wrote:
>>> We got the following lockdep splat while running xfstests (specifically
>>> btrfs/003 and btrfs/020 in a row) with the new rc.  This was uncovered
>>> by 87579e9b7d8d ("loop: use worker per cgroup instead of kworker") which
>>> converted loop to using workqueues, which comes with lockdep
>>> annotations that don't exist with kworkers.  The lockdep splat is as
>>> follows
>>>
>>> ======================================================
>>> WARNING: possible circular locking dependency detected
>>> 5.14.0-rc2-custom+ #34 Not tainted
>>> ------------------------------------------------------
>>> losetup/156417 is trying to acquire lock:
>>> ffff9c7645b02d38 ((wq_completion)loop0){+.+.}-{0:0}, at: 
>>> flush_workqueue+0x84/0x600
>>>
>>> but task is already holding lock:
>>> ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: 
>>> __loop_clr_fd+0x41/0x650 [loop]
>>>
>>> which lock already depends on the new lock.
>>>
>>> the existing dependency chain (in reverse order) is:
>>>
>>> -> #5 (&lo->lo_mutex){+.+.}-{3:3}:
>>>         __mutex_lock+0xba/0x7c0
>>>         lo_open+0x28/0x60 [loop]
>>>         blkdev_get_whole+0x28/0xf0
>>>         blkdev_get_by_dev.part.0+0x168/0x3c0
>>>         blkdev_open+0xd2/0xe0
>>>         do_dentry_open+0x163/0x3a0
>>>         path_openat+0x74d/0xa40
>>>         do_filp_open+0x9c/0x140
>>>         do_sys_openat2+0xb1/0x170
>>>         __x64_sys_openat+0x54/0x90
>>>         do_syscall_64+0x3b/0x90
>>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> -> #4 (&disk->open_mutex){+.+.}-{3:3}:
>>>         __mutex_lock+0xba/0x7c0
>>>         blkdev_get_by_dev.part.0+0xd1/0x3c0
>>>         blkdev_get_by_path+0xc0/0xd0
>>>         btrfs_scan_one_device+0x52/0x1f0 [btrfs]
>>>         btrfs_control_ioctl+0xac/0x170 [btrfs]
>>>         __x64_sys_ioctl+0x83/0xb0
>>>         do_syscall_64+0x3b/0x90
>>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> -> #3 (uuid_mutex){+.+.}-{3:3}:
>>>         __mutex_lock+0xba/0x7c0
>>>         btrfs_rm_device+0x48/0x6a0 [btrfs]
>>>         btrfs_ioctl+0x2d1c/0x3110 [btrfs]
>>>         __x64_sys_ioctl+0x83/0xb0
>>>         do_syscall_64+0x3b/0x90
>>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> -> #2 (sb_writers#11){.+.+}-{0:0}:
>>>         lo_write_bvec+0x112/0x290 [loop]
>>>         loop_process_work+0x25f/0xcb0 [loop]
>>>         process_one_work+0x28f/0x5d0
>>>         worker_thread+0x55/0x3c0
>>>         kthread+0x140/0x170
>>>         ret_from_fork+0x22/0x30
>>>
>>> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>>>         process_one_work+0x266/0x5d0
>>>         worker_thread+0x55/0x3c0
>>>         kthread+0x140/0x170
>>>         ret_from_fork+0x22/0x30
>>>
>>> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>>>         __lock_acquire+0x1130/0x1dc0
>>>         lock_acquire+0xf5/0x320
>>>         flush_workqueue+0xae/0x600
>>>         drain_workqueue+0xa0/0x110
>>>         destroy_workqueue+0x36/0x250
>>>         __loop_clr_fd+0x9a/0x650 [loop]
>>>         lo_ioctl+0x29d/0x780 [loop]
>>>         block_ioctl+0x3f/0x50
>>>         __x64_sys_ioctl+0x83/0xb0
>>>         do_syscall_64+0x3b/0x90
>>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>> other info that might help us debug this:
>>> Chain exists of:
>>>    (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
>>>   Possible unsafe locking scenario:
>>>         CPU0                    CPU1
>>>         ----                    ----
>>>    lock(&lo->lo_mutex);
>>>                                 lock(&disk->open_mutex);
>>>                                 lock(&lo->lo_mutex);
>>>    lock((wq_completion)loop0);
>>>
>>>   *** DEADLOCK ***
>>> 1 lock held by losetup/156417:
>>>   #0: ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: 
>>> __loop_clr_fd+0x41/0x650 [loop]
>>>
>>> stack backtrace:
>>> CPU: 8 PID: 156417 Comm: losetup Not tainted 5.14.0-rc2-custom+ #34
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 
>>> 02/06/2015
>>> Call Trace:
>>>   dump_stack_lvl+0x57/0x72
>>>   check_noncircular+0x10a/0x120
>>>   __lock_acquire+0x1130/0x1dc0
>>>   lock_acquire+0xf5/0x320
>>>   ? flush_workqueue+0x84/0x600
>>>   flush_workqueue+0xae/0x600
>>>   ? flush_workqueue+0x84/0x600
>>>   drain_workqueue+0xa0/0x110
>>>   destroy_workqueue+0x36/0x250
>>>   __loop_clr_fd+0x9a/0x650 [loop]
>>>   lo_ioctl+0x29d/0x780 [loop]
>>>   ? __lock_acquire+0x3a0/0x1dc0
>>>   ? update_dl_rq_load_avg+0x152/0x360
>>>   ? lock_is_held_type+0xa5/0x120
>>>   ? find_held_lock.constprop.0+0x2b/0x80
>>>   block_ioctl+0x3f/0x50
>>>   __x64_sys_ioctl+0x83/0xb0
>>>   do_syscall_64+0x3b/0x90
>>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> RIP: 0033:0x7f645884de6b
>>>
>>> Usually the uuid_mutex exists to protect the fs_devices that map
>>> together all of the devices that match a specific uuid.  In rm_device
>>> we're messing with the uuid of a device, so it makes sense to protect
>>> that here.
>>>
>>> However in doing that it pulls in a whole host of lockdep dependencies,
>>> as we call mnt_may_write() on the sb before we grab the uuid_mutex, thus
>>> we end up with the dependency chain under the uuid_mutex being added
>>> under the normal sb write dependency chain, which causes problems with
>>> loop devices.
>>>
>>> We don't need the uuid mutex here however.  If we call
>>> btrfs_scan_one_device() before we scratch the super block we will find
>>> the fs_devices and not find the device itself and return EBUSY because
>>> the fs_devices is open.  If we call it after the scratch happens it will
>>> not appear to be a valid btrfs file system.
>>>
>>> We do not need to worry about other fs_devices modifying operations here
>>> because we're protected by the exclusive operations locking.
>>>
>>> So drop the uuid_mutex here in order to fix the lockdep splat.
>>
>>
>> I think uuid_mutex should stay. Here is why.
>>
>>   While thread A takes %device at line 816 and deref at line 880.
>>   Thread B can completely remove and free that %device.
>>   As of now these threads are mutual exclusive using uuid_mutex.
>>
>> Thread A
>>
>> btrfs_control_ioctl()
>>    mutex_lock(&uuid_mutex);
>>      btrfs_scan_one_device()
>>        device_list_add()
>>        {
>>   815                 mutex_lock(&fs_devices->device_list_mutex);
>>
>>   816                 device = btrfs_find_device(fs_devices, devid,
>>   817                                 disk_super->dev_item.uuid, NULL);
>>
>>   880         } else if (!device->name || strcmp(device->name->str, 
>> path)) {
>>
>>   933                         if (device->bdev->bd_dev != path_dev) {
>>
>>   982         mutex_unlock(&fs_devices->device_list_mutex);
>>         }
>>
>>
>> Thread B
>>
>> btrfs_rm_device()
>>
>> 2069         mutex_lock(&uuid_mutex);  <-- proposed to remove
>>
>> 2150         mutex_lock(&fs_devices->device_list_mutex);
    2151         list_del_rcu(&device->dev_list);   <----
>>
>> 2172         mutex_unlock(&fs_devices->device_list_mutex);
>>
>> 2180                 btrfs_scratch_superblocks(fs_info, device->bdev,
>> 2181                                           device->name->str);
>>
>> 2183         btrfs_close_bdev(device);
>> 2184         synchronize_rcu();
>> 2185         btrfs_free_device(device);
>>
>> 2194         mutex_unlock(&uuid_mutex);  <-- proposed to remove
>>
>>
> 
> This is fine, we're protected by the fs_devices->device_list_mutex here. 

>   We'll remove our device from the list before dropping the 
> device_list_mutex,

You are right. I missed that point.
Changes looks good to me.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> so we won't be able to find the old device if we're 
> removing it.  Thanks,





> 
> Josef
