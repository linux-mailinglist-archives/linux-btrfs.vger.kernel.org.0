Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD57056175E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiF3KMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 06:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiF3KMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 06:12:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566B14477F
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 03:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1oUKRAamhRBgasO3wNq429J+0JIJOtrkd/QpLwnZhMkeq1o8PRPzKngjCpIYai2DiYJ7fgPzN2L78a8WyATMLIwxa9GpT9Z898flV2wCJ5Mg/n8l4m16THhnRmTJO27RPx37UQIrs6QLJNM/q1hxE5zZCwOSrFAzr8VtPpzn2q02QH1WbA/MtavEL3FvdLvehIcb+SRBK0Rq/cO3/Q0i94e2vSa6gIgmvo2PNVMtYNyjsHpxdH5XgmrZA9EhMmfZ+kAoKU23a4NJmp6Yb0DIvueBXwYUF/qhoXiiFshdzHBKYb7YAc4PVQhX77RFGAvcXppHIEH0FlHnzxMnYlEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSl7qKjRJYDIleKZu8bcuLuAS+nYmWR7IPgK7Wc7qkY=;
 b=gpXqZTnr5awRwdzjBLOb+1hmn76fPsIexQ8ISD6BIjAWq6oHgsnuRNPg2LhRji3YhH4oW5H0Dpj+qdtX2YNmFFFxvDeIGmko8nLCIa3xy/yRPBTImsXDk7Y/lrnA4Qs1mEWnbI+20FFYcGiWCNCScq+5IViwvbBDIK+F4jTSG16g5AA9KUZparPOb5PW5mWxeJe4r6NK8Vjsj60zYBSyZmekit8fXbL9xHEdErRRrSXXNt10DV/ou2ugq4dakLFAK6JUkR1Tw61V5MlgGU2y/BPFHv2/xBVHqch4DoGVsGfKWoV99DepGHW5z3XLAgg7XsINZ8EzYDDZtR59g9+YhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSl7qKjRJYDIleKZu8bcuLuAS+nYmWR7IPgK7Wc7qkY=;
 b=1HKeZS7L46iaiPJlMwKQ4P92EybGODSGYrp+CBuXZfHQhRDplQoKsScym5lDJXtE5OX3rXH4NQWt253yvnsbjPHaXwFdJ6qm7+g7BtJXjlljtfI2FG8Qybz5VDWTku4172+YxVb8DrqWryidN7Jf5WEBktiQMswOgLYgXT1SDMKUmvGXKEsYWr42jmIM3ltHA/AlBcBvRiEDQxHlIg5QfIDoYt+EM2tYVQn08QsCxWoS5WepmeHMNEyd70SKVezl5TQ+lXIMGw5YXaYFcG9CY7sL41bvfRvvL+VR+aDy/1EeMekWs+wnnf50eXaTaHJZgzyjv1vZ0OdYxEnu2NtEFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM6PR04MB5622.eurprd04.prod.outlook.com (2603:10a6:20b:ad::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 10:12:32 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::2581:79a4:26f2:44e9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::2581:79a4:26f2:44e9%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 10:12:32 +0000
Message-ID: <fcc974c0-75ad-f329-9c95-88395dec5bc7@suse.com>
Date:   Thu, 30 Jun 2022 18:12:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC 6/8] fs: sandboxfs: add sandbox_fs_get_blocksize()
Content-Language: en-US
To:     Simon Glass <sjg@chromium.org>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        linux-btrfs@vger.kernel.org, jnhuang95@gmail.com,
        linux-erofs@lists.ozlabs.org, Tom Rini <trini@konsulko.com>,
        Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <cover.1656401086.git.wqu@suse.com>
 <9f4b43b84a688b0367a87da2d4e0eb303a36bf32.1656401086.git.wqu@suse.com>
 <CAPnjgZ1yNXwQ44HBwe147hrC1mYsU4Lnyz-WVDHR_anwqYLBSg@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAPnjgZ1yNXwQ44HBwe147hrC1mYsU4Lnyz-WVDHR_anwqYLBSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::30) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee05e249-81ff-4e13-b5c0-08da5a810bdc
X-MS-TrafficTypeDiagnostic: AM6PR04MB5622:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BlkvijXvTQsWvPZ2sBW3mvbl4lGwWvrjFV4m1f2a/+h8xd8CmhO6KRciajuaoe4AtGL69J2QmRRTZPC+Qg9fZ3BAwdueJ+ZsgdGfa7IykxQuhXAxH2UxcUq8GlQO2+uHErs0vBwja3a1Ysaq0vQqOog0iO/YjY1RR2kxtE3yvdCw4EQXnfa6S6yxOSDlFLyICA42VWbSsXKlrRK3sts5g+/M4SHRlrjGocPhjv/xp7ME8deJ5ZkVU1KgQe5MKjKE1FDEE7VVlM31zRAn1wjQKKbnGVKnmyfnlqaviKUI9fOt1XVaGALNG68rzEbZQIjQNL0yFDek+BBe7NCnR+vvuL0vf/LiC+5TvluMNQ/ejzK1KoRMJY8B6A2ZIrqVsYa6zh1RV+LKqjxkuap96cwqYibrORMq1dr0C1621cTfIKTBS/vSYUi54DBww4aPHaX5wxcgpGhedHIBMpetp+uDaXR8tmiqYbcxrq3ayZ59w4cZVjuX8wgSAm9Yt0p8TKpJaT7cZkw5g3mDe45uwUJYG0ahE0bnbgKpVdY4v7fOh7aMWFnyD4s32tJ6/fm6LEldqGkFH1AS9/NCaviNHpw+3xVxNHBU7GJd6trtU2Rc6lDlHE5/JkK4A2vP6GGDwu5NQKW3fdrR2dxBzcn4Wlwt+maURvX27EfJGLn7hx4A2HyWvxlfeqYUgToAv2wyx5qroPoCW/a21TmPPONHXv55r+TwtxtEx5lzGOKu1hqnEAwFi20QjzZN/U3icAlpCQpU3ahUmwlpBlM1NFlyV47EP3psPgxO2K2G3BS2BXhffR29nR9CwFc/FsEd5BNXwsJMCuy0tgdHp0D8h6NqiX1TEbda3qz35wAPQPMJo8iRaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(376002)(396003)(83380400001)(66476007)(8676002)(31696002)(186003)(966005)(86362001)(36756003)(316002)(6666004)(8936002)(38100700002)(6486002)(31686004)(66946007)(2906002)(53546011)(478600001)(41300700001)(5660300002)(4326008)(2616005)(54906003)(6916009)(66556008)(6506007)(7416002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUgxL1pIcW5tbDk0bDBTbWZERmVzSHpHRFl2T2FyQk1mZlg5VjdzcldBTFUv?=
 =?utf-8?B?cVBXZ3Z3eENiWUdPUlhuL3hVU1Y2VEd3QVF3VDlqbW9oeUQ3aEM1U3d2YzdY?=
 =?utf-8?B?allWTWVHS2JUc0JkcVUwUG1Ydm9GRzN1UnB4eStVUU1OK1pHNDdlNFcxL1lu?=
 =?utf-8?B?ZktBY1JaOFNSbHpSMWhhek0reHZLSlpoY1dmQWZna24xZ1JVcGNHUWJDYm1m?=
 =?utf-8?B?Nk1EZFFxTlNYWDVOMDhrUFJQL25BUnpwd1pKdE1hcGZoNWhBcG1OamhuZlkx?=
 =?utf-8?B?SHR6OThMSTY1eHFWV3FkSFVuSEJVdWh1QXBBMUhXcWZ5eG1BVFN2N0s0REVX?=
 =?utf-8?B?TFp6aXpQTS95Zi90a3d5RjBOVGtTSXVLWUUzSDQyU2xPNkVTalpXY3NnSUJQ?=
 =?utf-8?B?RVZzVHBFd0sxRktvYkc3QnpWUjFpcEZsUHh2VklzdklXci9QZDlpNlRWNHF3?=
 =?utf-8?B?MVFTdXpWMFZLR2pCaE9TdEgvaDRsUnUyK0FpVFJGSjR2Mjl2ckEyb3FiNm5a?=
 =?utf-8?B?SU14UnVOVEYrQlRQc3ZJQ2NLU2ZJNFBNL1NHWXVaMGxibTdpWjkvOHVrcXdo?=
 =?utf-8?B?TDg2R0lFdE5oMFk1NWxpSUhKK25TZ3FDcmRndUQ4c2NsMFdPa0xUTHdrcmJD?=
 =?utf-8?B?Y1g3WkJPWUJHMURGMTFCVjd1cytFbXlTY2t0Tzd1WUFQUmdRbWV6RzVoSG5W?=
 =?utf-8?B?eUdhL3RBQVhlOTNtMk4vaFJnNU92UkdmQ2dHYjZ4cHlOT3BOZDBZbXV5a3dU?=
 =?utf-8?B?c0Fjb3dDVkJSSEMyTzJrSkNqdTAyQkNCdjgrS3Zpb2xOVmhRb2VPOEI5ODd5?=
 =?utf-8?B?VG9qNEkxcGZzOFlYRGpTdFF5dmZXMWZDM1RFZFNxSmhwelhIYjFSVVVJRkU5?=
 =?utf-8?B?bkVXZkdRYzEwdUc1bzFOL2Nhd3FNUHdDQmZlMmNTN1pLYjRzSzdMa2VvWlRL?=
 =?utf-8?B?RXJSR2NiSGY5UndhRDE3cjhnZUovb1JXM2dxb2ViNDBVTEUwdWV2YUtRK3pZ?=
 =?utf-8?B?VFhwcUJnZlJNdVEyUit0NVl4YTdyT2M1TVhqMlprRFhJOVZQd3JFVXFsQkF3?=
 =?utf-8?B?Rzd0MjErYVU0a3JVbnlyRlRQZlBaRFpKSEZUTlBBc2pQcnVIT240elNTSG5S?=
 =?utf-8?B?ejg3dkZpdER0bTlXWXlyN2F5SEwzcFQyMjhUT3JQd2x5RlhLNldKaktNNm1h?=
 =?utf-8?B?MlRBYW5iZmc1d0EvRWY2ZmFpWk45MmRqVng2amtWdEZ6TnlJS2tIa0lycmRC?=
 =?utf-8?B?RXBURVh1YXhmbFREV052REQzK3hIQk43czBLbk1pcnZDMWRVV3I5RFQyTEF2?=
 =?utf-8?B?RkRXdDFVcWY0c2ZXUW9rKzZTU2tLS2NLVVBNNVVXdjZsTjUwMkhWWlp0d045?=
 =?utf-8?B?QUtTNC82RmZtUHhORXFiS2hXMkFMS2dtenhTcGF2RGZQMU5jOTN0cUEyY3Z5?=
 =?utf-8?B?V1ZvSitEN3ZIWWJhTytMV3VRRXcxSFVhRVlUR0MxS0k4MXQvY2FSaDRsRlZ0?=
 =?utf-8?B?aXAxcGlTRVZlWndrMkF4OGVSbVdsUmpjV0NPaEUvOUhtNTBCdUJpT1ZnT0ND?=
 =?utf-8?B?UzBGSU1LekRPd3pqK2QxRktNT0Q2RWpMUFAxNzdlK0o2T3JHNlJDLzNqU0t3?=
 =?utf-8?B?TXJOZnlzTlVlZXRBNkxERGlBNXMrTXBxZnpmOXIwRm1kRlIwZ2lxa3lueVps?=
 =?utf-8?B?Nkp4dWNjdWFNQ2grbFNLYVczelZ0MitzeERRek9TUVYvMXBTRjlPQURiTmMx?=
 =?utf-8?B?dHNZQnhtN0hydG5tUHZ3VDlkWVU2ck84OTBDU1dEeHpiVXlxQ25TcTJpT0Zh?=
 =?utf-8?B?OVlOTlpLbis3QS9EYWZkMWNLNkxidTFpNUNieWNTcU50WmxKRDFhU0UwT0Jm?=
 =?utf-8?B?M2EvVk5lMTFzM3BMSklRUmovckJZRzlnajJRRGZmOG1ibXJxbEF4elhIcWpq?=
 =?utf-8?B?blZxMmN1aHhwMGdpNUVzZnBMTjBCL054WUdpUE92TTlTbjhmV2xZdkFLRTFv?=
 =?utf-8?B?WjArR2dCbUpxdjMzMks0TlQySFlZOE5GQnNPWXBDUnRkZStibDN0cFV4Tkdh?=
 =?utf-8?B?UmZyVXhKTnZXWkdSR1Erak4wYUdmb1ptQytBc0lKUXhOejhqN20rMFhGVC81?=
 =?utf-8?B?MUt1ZDg1OUVTL0Q0ZUFuZEQ0L1NSZGcrSUcwbE9OcEdjcmxPVUQzT2lpbXEv?=
 =?utf-8?Q?3J5/G5udjJKGyJnZQKedjfM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee05e249-81ff-4e13-b5c0-08da5a810bdc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 10:12:32.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKS5rWWAu9k1A2E96uRKTV+lpWcFwAnr3PvZG4QkP+7JkWkckvCCfvs2o5fNlA48
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/30 18:06, Simon Glass wrote:
> On Tue, 28 Jun 2022 at 01:28, Qu Wenruo <wqu@suse.com> wrote:
>>
>> This is to make sandboxfs to report blocksize it supports for
>> _fs_read() to handle unaligned read.
>>
>> Unlike all other fses, sandboxfs can handle unaligned read/write without
>> any problem since it's calling read()/write(), which doesn't bother the
>> blocksize at all.
>>
>> This change is mostly to make testing of _fs_read() much easier.
>>
>> Cc: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   arch/sandbox/cpu/os.c  | 11 +++++++++++
>>   fs/fs.c                |  2 +-
>>   fs/sandbox/sandboxfs.c | 14 ++++++++++++++
>>   include/os.h           |  8 ++++++++
>>   include/sandboxfs.h    |  1 +
>>   5 files changed, 35 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> with a comment as requested below
> 
>>
>> diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
>> index 5ea54179176c..6c29f29bdd9b 100644
>> --- a/arch/sandbox/cpu/os.c
>> +++ b/arch/sandbox/cpu/os.c
>> @@ -46,6 +46,17 @@ ssize_t os_read(int fd, void *buf, size_t count)
>>          return read(fd, buf, count);
>>   }
>>
>> +ssize_t os_get_blocksize(int fd)
>> +{
>> +       struct stat stat = {0};
>> +       int ret;
>> +
>> +       ret = fstat(fd, &stat);
>> +       if (ret < 0)
>> +               return -errno;
>> +       return stat.st_blksize;
>> +}
>> +
>>   ssize_t os_write(int fd, const void *buf, size_t count)
>>   {
>>          return write(fd, buf, count);
>> diff --git a/fs/fs.c b/fs/fs.c
>> index 7e4ead9b790b..337d5711c28c 100644
>> --- a/fs/fs.c
>> +++ b/fs/fs.c
>> @@ -261,7 +261,7 @@ static struct fstype_info fstypes[] = {
>>                  .exists = sandbox_fs_exists,
>>                  .size = sandbox_fs_size,
>>                  .read = fs_read_sandbox,
>> -               .get_blocksize = fs_get_blocksize_unsupported,
>> +               .get_blocksize = sandbox_fs_get_blocksize,
>>                  .write = fs_write_sandbox,
>>                  .uuid = fs_uuid_unsupported,
>>                  .opendir = fs_opendir_unsupported,
>> diff --git a/fs/sandbox/sandboxfs.c b/fs/sandbox/sandboxfs.c
>> index 4ae41d5b4db1..130fee088621 100644
>> --- a/fs/sandbox/sandboxfs.c
>> +++ b/fs/sandbox/sandboxfs.c
>> @@ -55,6 +55,20 @@ int sandbox_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>          return ret;
>>   }
>>
>> +int sandbox_fs_get_blocksize(const char *filename)
>> +{
>> +       int fd;
>> +       int ret;
>> +
>> +       fd = os_open(filename, OS_O_RDONLY);
>> +       if (fd < 0)
>> +               return fd;
>> +
>> +       ret = os_get_blocksize(fd);
>> +       os_close(fd);
>> +       return ret;
>> +}
>> +
>>   int sandbox_fs_write_at(const char *filename, loff_t pos, void *buffer,
>>                          loff_t towrite, loff_t *actwrite)
>>   {
>> diff --git a/include/os.h b/include/os.h
>> index 10e198cf503e..a864d9ca39b2 100644
>> --- a/include/os.h
>> +++ b/include/os.h
>> @@ -26,6 +26,14 @@ struct sandbox_state;
>>    */
>>   ssize_t os_read(int fd, void *buf, size_t count);
>>
>> +/**
>> + * Get the optimial blocksize through stat() call.
>> + *
>> + * @fd:                File descriptor as returned by os_open()
>> + * Return:     >=0 for the blocksize. <0 for error.
>> + */
>> +ssize_t os_get_blocksize(int fd);
>> +
>>   /**
>>    * Access to the OS write() system call
>>    *
>> diff --git a/include/sandboxfs.h b/include/sandboxfs.h
>> index 783dd5c88a73..6937068f7b82 100644
>> --- a/include/sandboxfs.h
>> +++ b/include/sandboxfs.h
>> @@ -32,6 +32,7 @@ void sandbox_fs_close(void);
>>   int sandbox_fs_ls(const char *dirname);
>>   int sandbox_fs_exists(const char *filename);
>>   int sandbox_fs_size(const char *filename, loff_t *size);
>> +int sandbox_fs_get_blocksize(const char *filename);
> 
> Please add a full comment.

This is already removed in the formal version:
https://patchwork.kernel.org/project/linux-btrfs/list/?series=654990

As sandbox is just calling host OS read() to handle IO, thus it doesn't 
need to bother the alignment at all.

Thanks,
Qu

> 
>>   int fs_read_sandbox(const char *filename, void *buf, loff_t offset, loff_t len,
>>                      loff_t *actread);
>>   int fs_write_sandbox(const char *filename, void *buf, loff_t offset,
>> --
>> 2.36.1
>>
> 
> Regards,
> Simon
