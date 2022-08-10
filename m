Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8648458EB1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 13:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiHJLSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 07:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiHJLST (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 07:18:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D71C73306
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 04:18:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8hhA1005452;
        Wed, 10 Aug 2022 11:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=htr2h1MI2QWSSLUW5CFXXVAcV5OVx9/YznjtyNyRa7Q=;
 b=TIraLxjlJ8uFnszxPMNSJp0ak6RrFZJ5B6qbEsulkaDE8d5jgaLVchWOcrRENVwmP5EO
 JZ3cVF7lJtpVvLhKazABfuLQO9Ju3N28pyzwzQGIgATyePzJZ6lpOgnczlmkCh2c9sqY
 9ZkCmyYjyzx2yCFmVXsTAjaZuVN+putULnBONI6PzZ4AEgptJ3bTUYoDFj8j2eZpE5K2
 sSU1zmNGtePk0z5XlhAqtM438ofklxiM8xjHyTXWmtlCRNYVztgBtgunqzUO6DrRO03k
 ggQnIXeQoqkmOTSCzeI4Rp9pL7xYZPXBlBWp7oDFy7JFRbvTZnX59XCBUjMHodB46D11 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwq91ks9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:18:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27A9KrQL015358;
        Wed, 10 Aug 2022 11:18:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj1s2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 11:18:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBRWZnKePmiQJRURsJz1ogbo62+KLXvVmOJzk0GvR3HUhJAaTdWRVQ4PoaBs/0yl1ntpMcbCkZpi3V/MJj7036vvQIcp9tRKhKW4JM8TKlnFHOEcVKp53nGCd0uNtYCGTmbgOUJiKPPHk7OnQpfvFrhPAtuMkQkm5EwAEIRuTuSBU3xXegzmtqVtSSNa+7bTR/ORDSDg3kw94hwqQ+/nRWFNDgxMZcFg5qPvEhMvi4B2qFwxIXYz/prvwyXlQlxWXFiVmDpfvIAqkoiOa+WynHTRjc66gqRT1uWKknoHHtqSrwPbD2PRKtcAHOD54rtqrbcCaoQbbKAhwzQqULiWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htr2h1MI2QWSSLUW5CFXXVAcV5OVx9/YznjtyNyRa7Q=;
 b=NtfpkxQZ5+Y2zNLKDm3xERUQeoR4x2SoQVojgxwOj4NZuW0agiIHDU2+todj6zT7Lm625X/j/oq0+LtFTY2o4rXkSDoorcQesNrIPnGGtyHx/zzT4JUf52B1ydVY+7sXUtUTZUoDd95JD3zSJBmAa8GxSUHJUWiWaY4RaUo4oZTdsT4sB81Qp8TJVOKHOyfrp0+mqaq6d+6+ZuSKQS3zfoUIwAlVY1LMBvi7dUBvMRmsN6hnUXEbFY7s2NM2BbDjWRP/pcy/69UnzKOrVU4SirwwcTja7LU9RFD9AHnOszfl2KhElP0jE3xPRh2058WaUEFyPpkD96ewqWRiYmdnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htr2h1MI2QWSSLUW5CFXXVAcV5OVx9/YznjtyNyRa7Q=;
 b=fa8ivxfM46w6U/O0Zq5ce9hUzwVOziN3EslE4Bxx+Z13AVspZ8xKFoI5tfFIX7FQ6BtqRTdlG5BouLcFealAno6Hh8AAMBCuX51LDJMnd5Km6nhJsocVvHWhr/Y5Bbc0yPoiSGh+OpyyvqoAPcwPDoUgQ9otqjuAHCHzntJKOyQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY4PR1001MB2135.namprd10.prod.outlook.com (2603:10b6:910:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Wed, 10 Aug
 2022 11:18:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 11:18:11 +0000
Message-ID: <e7c12925-57e2-0ddc-2297-7e2a90599379@oracle.com>
Date:   Wed, 10 Aug 2022 19:18:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1634598659.git.anand.jain@oracle.com>
 <c2bcb950-0cc4-2e6d-4a77-36fd2f337aa1@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c2bcb950-0cc4-2e6d-4a77-36fd2f337aa1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1c5aca-6416-4d33-8c4d-08da7ac202db
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2135:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kWLWzt/3bq1U6/LLycisBdsNygWC/U1Qs+tCU2/YXI/IhwHoiTzHA4jmORaMYD7z7m0resxUw0PwN14rH09IGzlTKKR6WkzXUyfRZufL6Xm2dvHLKiorS+aIiKnwlkPF7gZdzYbONj93SkXQSS0ZyPW1c2dWsQ8A+k44O8eb3zeHGr5+tMkoV3XgC/A44/CmtbLDdEorQyPlPE3OF8rzv/0lpb7SqO90vq92B1oCFnTgN2PgV3Y7tCpDj0z+/se4QAb7B1aw08NOf/Lyw/naDK47WUaQ14oRj6FLNMeibw2zZEBtkS3Lj0JLzDPFvtiV7fg253vJn2T8eQYLJIIoqStkUZYgRvWII7df7p51uKpVSIWt2C9+GPyxXxcGh+seR7o3qskmZutgOW4sNCBtaNkqvr7vI3ZNW16ktOWvWip2UxHLB1+VBHwS9gTn1emuMaAOI6VpmXod5+Q1laGHzizoWKekbNi9q1aCk6XEBCvTAy3yZ8bSsmA8vNsUpJi5aak97IKDFg+ryAxQY5LwUE5JU8VA+YchPP+tT4NjzEZzPjpIPMdm0Ss0Fy/6ZxERpU0RtTe+Bji+cGw9MkiNeD/RpZYdhcf4WsLV1TxL5hyXa8j66Xv/9m108qVg0Tbx+orZSYyTaucAJpG7iseXFTdaDaydtUgNL72Wc3Pu2dlth3m9JM7FsqxANMQr0UuhBLmHwcJqissv6zUnaYUG0+QFDUohmiMdO0IaEHWFh9CbB5HAxJJTDS6OXjVv2Aq5br355DG+RSZ7n1PD4i9FdbjQqDMJ3Yv10spCcNrjIMiGE2AsX4xfVrrsg9nC2IpxxTXI2/KE5lrrTL5l4Eyog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(136003)(39860400002)(396003)(53546011)(31686004)(44832011)(66476007)(2616005)(38100700002)(6506007)(36756003)(186003)(8936002)(83380400001)(41300700001)(86362001)(6512007)(2906002)(66946007)(6666004)(26005)(5660300002)(478600001)(66556008)(316002)(31696002)(8676002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlnWklLdW5mOXRYdWE5V3paaGZlcGx2ZkVUNlNoalRVeVpvV0FMNkVEaFl1?=
 =?utf-8?B?bnIxQ0NwY3FqcjVDWVdNWXlEQVFpUEJVY0VxSlBNM2dhR1pVcnlkMVRVSk1Q?=
 =?utf-8?B?cU0reUhNbk9Na1RFOW5tbEoyUklOaTVtZG4wQjdJMnh5WEtDZlZvemFIQXNR?=
 =?utf-8?B?OU5qL0ZIQURNd3diazhWR21jSUV2alU0TzUyQ0VNWk9HUmk4VmdBOHhkK1R5?=
 =?utf-8?B?cVBHUVpTQlJCOVFMM0dENXdSSmJkSC9KaW1UY2JqOXh6Nk52SjRmanp2MWVk?=
 =?utf-8?B?aHFCUXNrTEJxZUNnWTlOQi9LZTJSM0VMZTIzRFY0UDB4VVNRZ3VBYm1SWmJ6?=
 =?utf-8?B?MW9qL1RPdndjOWwvNUVOOXFkMFpJd3RBSDBJRlViMlF0TkdlUkJvMTFFUTZr?=
 =?utf-8?B?R1Brd2J6Vk9vUU1XVWE1REJkMGpDTElnVjVMMmpzeXVEQSt5c2wvQUtzQitW?=
 =?utf-8?B?cUF3S3lSRlVoSHViMlUrQnpMZSsvWExNU1BGQUljeG1MelBVZnE1NWJSZTUr?=
 =?utf-8?B?RDhQN05nTEEvZlFIeHh5dUJDVmN1YXBqRit4NDFpOEFsc3V1VkRvQ09MRmNZ?=
 =?utf-8?B?V05GS05PeCtjYTdNZ2tFN3lxZXJKajZyRkx1K0s3VVIwbWNqWk01Ui9DdFRC?=
 =?utf-8?B?U1lEcllmZHI2SnMzeW52QnlJTEZkckg0RTh6TGI2RjhPWktGbkVTYzI2WThD?=
 =?utf-8?B?TUlnaGRHYjkrNlNhU0h2MEhZTTFudEtOaUtCNStOdUloOUxDOGNBSDZnbVpt?=
 =?utf-8?B?TkFSZkdXTUliYUZDc2tFc2w4a2Z4NnAxTkhHaFFHUFQwWi9Oa2MwQlhuSDVJ?=
 =?utf-8?B?Rm4yYzhvYU9lbytmUEhtZ0tqZWtQalBaWEp0T1VrTTIrTVVFZ1kxbzY3Z0dp?=
 =?utf-8?B?UVU1b054QjdJN3lsWi9TcmRaSGMrVVVLUWYrbG56RjVKSmdBYnNqd041dUIr?=
 =?utf-8?B?L2NkRmN3QXNDUUhzN2oyTis4ZnRoUDArSmxxZHdaY20rcHhhRlBnd29UL3ZW?=
 =?utf-8?B?bEZrVldRVzRWME9QSmQveUl6bGgwTkJBVDUzVzBrS1lLVUQ5YVBrU1RGZHRs?=
 =?utf-8?B?alpQejNlclNBaTVVbUZRajFseENKakY3TWg0b3ExRGNiMmtHQXBZOHNzNUYw?=
 =?utf-8?B?cW9OcUQ0eklVM2NITVFaNlZLQlZidmNzR2I2NWJ4UWVvZjE2SlZWS0pTS2FJ?=
 =?utf-8?B?M3BYWEl4c1ZqYnFUWVlBK1o1M1I5aTZvMXpHbmZyaUswSjMxaWQ1UjRmWUdF?=
 =?utf-8?B?VzFIT0hFQnVkdHBmcVhCYk95Vm00UjcycUMvRWJNZnZoNjRhQmRZa0ZhbmFp?=
 =?utf-8?B?ZWdGUVJpYk9vYzFZQmpJOVpGSW9mYUg3MGNuWkswbzJqMzJxYVY4MGhHUGNX?=
 =?utf-8?B?K3pFeExCTFJodk5LWjFYZllBU0s4d2pkRElYa04yL1I4SUtmRld4aEZqaUFa?=
 =?utf-8?B?bVF0QUpRalQwS1YrTGVYcFVZWVFVazYwa0kyN25KOTJ4djZBenZ0ekpsNXRP?=
 =?utf-8?B?ZXkyRm16SHZBSy8rWngzVVFhZG5ZUmdQNWdqSHFlMW9pVzM4U1hLZlVPK29J?=
 =?utf-8?B?ckFZaE1PZXNoT0F5d1I4V3YxSFB2NkpWSGh2M2hrQUs2eGhJV2tXK09yUUN6?=
 =?utf-8?B?U2tDcU8yQ2doRFltV0E5eU04cHNhKzlQbDFwQjFNOSt4N0p3VmwrNHJwQlh2?=
 =?utf-8?B?aUw3Q0lraEpoc3VmSHF1VEl6eXhSZFYrNXlKUEFQaUVacFBWdlROcGN5eUR6?=
 =?utf-8?B?T3MzdGE4SDBCL0ZBK2g1N2dSb2NYSmdGSmk1U1BkRnlUeHg3dnh4YjNQQld6?=
 =?utf-8?B?OTdjZlU3UTdxclorRmhWaEMxZk5Eb1Z1WFdSRGhyRzhhT1MwSkFzUnQyaXF6?=
 =?utf-8?B?eXQ0OHd2WE4vQmN4dHM1aTVkNXhPT1RZRkNpN2hYUnBRSCtPWmhFRkU1eHNH?=
 =?utf-8?B?RGdBbzFPYTR2YkdSMUpkcEMzcnBGS3BiaU9kQmt3RE9Pa0hldi9zMWtzenJn?=
 =?utf-8?B?WFduTUtWODhpUXNKcU5GNjRhMDAyMVZXYTFzNnN3REw4dzkyMndpQ1lRK2Ew?=
 =?utf-8?B?VytlTjRZOWkyZUN0TGlCeFJFTWhpTUhpdHdBelFUZit2dzFCbzk4aXVEbHpy?=
 =?utf-8?Q?QghlnIPMfEVIh3z2YV2P1yVc3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1c5aca-6416-4d33-8c4d-08da7ac202db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 11:18:11.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdy3CHerkNUWVPKGRqT16n0L7xjhYiW9uGmoULDeZTWkns87D29Ef8PRMlEkBe2etxs9G/G4DBQRYpbGl21qYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_06,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100034
X-Proofpoint-GUID: 7az5mJFidNJUR6CHv454REJ25iZN1LLn
X-Proofpoint-ORIG-GUID: 7az5mJFidNJUR6CHv454REJ25iZN1LLn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/08/2022 18:18, Qu Wenruo wrote:
> 
> 
> On 2021/10/19 08:23, Anand Jain wrote:
>> The following test case fails as it trying to read the fsid from the sb
>> for a missing device.
>>
>>     $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
>>     $ btrfstune -S 1 $DEV1
> 
> I just wonder, should we even allow seed device setting for multi-device
> btrfs?

Hmm. A desktop use-case which gets reset back to the golden image at EOD
or a user logout may use fault tolerance to reduce unplanned downtime.
I say we keep this feature. Further, if we allow a seed device to
replace by another seed device it will help also.

> This doesn't sound correct to me, and can lead to split-brain problems.

Split-brain can happen even without seed devices. There is a patch for
split-brain detection and avoiding. I love to revive it if there are
enough interests.

Thanks, Anand

> Thanks,
> Qu
>>     $ wipefs -a $DEV2
>>     $ btrfs dev scan --forget
>>     $ mount -o degraded $DEV1 /btrfs
>>     $ btrfs device add $DEV3 /btrfs -f
>>
>>     $ btrfs fi us /btrfs
>>       ERROR: unexpected number of devices: 1 >= 1
>>       ERROR: if seed device is used, try running this command as root
>>
>> The kernel patch [1] in the mailing list provided a sysfs interface
>> to read the fsid of the device, so use it instead.
>>
>>   [1]  btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>>
>> This patch also retains the old method that is to read the SB for
>> backward compatibility purposes.
>>
>> Anand Jain (2):
>>    btrfs-progs: prepare helper device_is_seed
>>    btrfs-progs: read fsid from the sysfs in device_is_seed
>>
>>   cmds/filesystem-usage.c | 47 ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 42 insertions(+), 5 deletions(-)
>>
