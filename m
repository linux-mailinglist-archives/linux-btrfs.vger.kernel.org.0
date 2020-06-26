Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8CD20B4F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgFZPkb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 11:40:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59758 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726824AbgFZPk2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 11:40:28 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QFZWwm013159;
        Fri, 26 Jun 2020 08:40:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AdmqhIy0Gm8was73V7lMWFkX6CC7Nl+1zs+S3LuU8Bk=;
 b=hVhp7NmVPqHNRE9c0N2jTqYbHx9nFTeNzSJeAY2lLsWFbLIV9wP2KU4LzJpGygCFzKt0
 rV8+ZImOWQzcUmJgO3J4FwBPF5Jwa5bJBcBYE9srQvfjceGaO+c+PKIJcZKU7+iLT3Qc
 KppV9A3pwsvEAUgM97kJwzCubIWI5D6s0j0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31ux0w5yw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Jun 2020 08:40:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Jun 2020 08:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sdk1VbJDsSdt/LgPnEiRRVhTyXg1Upjw06mDGr+kwaC5ejyST/7NtudsU5P0RDSOudv8k4RRFBmdBjFXUaRsE+XT0rBn4lM82KQIKVEbql/0+/Z+ZQ6QUypnHkhjX8zW821w6f4b1KsCIhBoBb2udeMGRdouLc4s9Y4CXTOapbR/5x/Qd/G1H26Fm1TJl7n14FbIGPhzIJ2V52OtXvBrP2HZmLZBF1+C/Srgv8MRmxkKNPFzU6+nHkGOz4TYGu4gx6o4rx8LE6MMpxElA4FpdM7qIvmr5XjUfM9BDSZKUPgUhXDXmBXGoq3nfxSZJa+kzNVZzSF2BaHr5IqRXu2S9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdmqhIy0Gm8was73V7lMWFkX6CC7Nl+1zs+S3LuU8Bk=;
 b=QRyi2CFJs0HiR6PhGfCSAAl4u53mKEISPp3j8C5+eHS2rlvPcXRyldG1zBobIGLeSoNsElzS7dq0e4PyVPtBJnJjl9PUocYtxgjwKiAgavE4QPP/ljsd6bFFjkkexGYNODHhzmGbhbCg+eb8Y4TXwBhAm6mZcitYlY/Hdj/rn4JsMmo9YcqeOn8sc76rzP+37HZwLHz3O6HjzJTUmfhq83CAGO30eTu2OlYA3qVEHz9aNlcWRkyH94+m0lR9iPGUVSt8W8DZFHkL7+QR3JgdVOCmPxazc/k6nB/fhyYNDz1of1eEcIMG5PSNQ+ZdHKyJOGP89lLJkD2awwdjQbOn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdmqhIy0Gm8was73V7lMWFkX6CC7Nl+1zs+S3LuU8Bk=;
 b=SirV7P1poR0fV6jpaOHG2Vpq412lau45eqypH+pr+lsGsd5u90kQQ6Ly1sm5WrgKIOHnQGGFqy3tHD9KTSW8LcQ7EnOLU3iejv7jiHtPI3AxrY4t6rP1+833Ds/4OvbhJ06nVMrsFkalYrgaYBgRsseslpUt2pnH//ltZ61l7+s=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from CH2PR15MB3608.namprd15.prod.outlook.com (2603:10b6:610:12::11)
 by CH2PR15MB3736.namprd15.prod.outlook.com (2603:10b6:610:6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 15:40:24 +0000
Received: from CH2PR15MB3608.namprd15.prod.outlook.com
 ([fe80::5800:a4ef:d5b3:4dd1]) by CH2PR15MB3608.namprd15.prod.outlook.com
 ([fe80::5800:a4ef:d5b3:4dd1%5]) with mapi id 15.20.3109.026; Fri, 26 Jun 2020
 15:40:24 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Tim Cuthbertson <ratcheer@gmail.com>
CC:     <linux-btrfs@vger.kernel.org>
Subject: Re: weekly fstrim (still) necessary?
Date:   Fri, 26 Jun 2020 11:40:22 -0400
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com>
In-Reply-To: <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
References: <20200621054240.GA25387@tik.uni-stuttgart.de>
 <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de>
 <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de>
 <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de>
 <20200622142319.GG27795@twin.jikos.cz>
 <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com>
 <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0108.namprd02.prod.outlook.com
 (2603:10b6:208:51::49) To CH2PR15MB3608.namprd15.prod.outlook.com
 (2603:10b6:610:12::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.13.224] (2620:10d:c091:480::1:c29b) by BL0PR02CA0108.namprd02.prod.outlook.com (2603:10b6:208:51::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 15:40:24 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [2620:10d:c091:480::1:c29b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9464a212-2acc-4491-f52a-08d819e73e49
X-MS-TrafficTypeDiagnostic: CH2PR15MB3736:
X-Microsoft-Antispam-PRVS: <CH2PR15MB3736CB4E1E1E719799C181EBD3930@CH2PR15MB3736.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olXr+zS//VWich9Wpk7YWfxzhVPYLZkn7OUMQfYk/ALW2jh30K5g7ZFscO8EPPtQWVs17XbUd3Cw3j+NYEGkm65OBlTIBJstpj1u3tihyVmEj9SmXnLLZVB0WpBpdPePVqIZTTlqlQcjh4DpOXxoDVPg3zqcGndZLd+iX1qxMZCd1HCYIOBgYzqb9Pnz3KapBdDCn1MXp1pVE0C/UQXEkMgcQA/Ht64fXEx133jNn7yRI7X4FVdDJBjT0pfqSN6Gd9src+l9psakgu7eSUWJDKYle5AzYAb1gOLzJwDPKBEbHd18e7Fy/yHUdwQM3LxQw7TMb80UYfySrm7HqM7/sLMWG6FTc8uCLFsdWaiYCEA3fc5/OW7ULmIkJDqHKHHxofeXlcaPcQUXH6FT0JJ/jVZtpmXGokIOfoTrosBVbcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3608.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(2616005)(956004)(66556008)(4326008)(66476007)(66946007)(2906002)(53546011)(8676002)(83380400001)(86362001)(52116002)(8936002)(316002)(6486002)(33656002)(16526019)(6916009)(186003)(36756003)(5660300002)(78286006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: DfjTtlQfrEedIjsOBis+8IaQhbvA2Buo4nXrWADVCe9/zJsuUrpvSyEnduv5B0HJ8Bnh0XVicl42j4IP6po0MrzJSeIasYHgoY9osV+EE3lb6BT77KTs49fuZke+H2pPOtYgu89fGSPT+TplgbBEz7vkqSPV19ct26TaaZnYf/jAxcD60yDArr5l/eE13BP+qEYv4NhSnmZBVbvNTr0XV/wuSh6Dg+fsFemAkMiZKDklLcBooBrldgt8rL2D/Tj48YvCEhqy81y/H/WXEXNDKSZ4eGhng+S1AfKdk/vZPT/OeBzk0lAU0r9zIwU1/tpyjpqfMiDCKmhVI66ToshzTC5aotAkSWLDWBbrdZS8tDYzf5wMyoWPar5f5+QESYiDbsVP6R6gqHanclHMmQN5dUxoDZPWVUQJmjSF6z96Ppldcx999mWd9IFIfk9B3dGw5PhZ2QEylsrSIvQ+4XynRyoAGl1/ujbGclIqtmcNHwdDeUGBSBOR+qoYGgnw9L2ldPlgaH6eigYbvyYiRIk6Ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9464a212-2acc-4491-f52a-08d819e73e49
X-MS-Exchange-CrossTenant-AuthSource: CH2PR15MB3608.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 15:40:24.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +u5c8O4DYZkx+Sna+FfEttx9V5VTnZ8WMs+Q0U4tKmTffaaxocxepbMETpxFOGPR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3736
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_08:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 cotscore=-2147483648 mlxscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1011 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260109
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26 Jun 2020, at 8:08, Tim Cuthbertson wrote:

> ---------- Forwarded message ---------
> From: Chris Mason <clm@fb.com>
> Date: Mon, Jun 22, 2020 at 10:57 AM
> Subject: Re: weekly fstrim (still) necessary?
> To: David Sterba <dsterba@suse.cz>
> Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
>
>
> On 22 Jun 2020, at 10:23, David Sterba wrote:
>
>> On Mon, Jun 22, 2020 at 04:02:34PM +0200, Ulli Horlacher wrote:
>>> On Sun 2020-06-21 (18:57), Chris Murphy wrote:
>>>
>>>>>> You need to check fstrim.timer, which in turn triggers
>>>>>> fstrim.service.
>>>>>
>>>>> root@fex:~# cat /lib/systemd/system/fstrim.timer
>>>>>
>>>>> root@fex:~# cat /lib/systemd/system/fstrim.service
>>>
>>>> I'm familiar with the contents of the files. Do you have a 
>>>> question?
>>>
>>>
>>> You have deleted my question, it have asked:
>>>
>>> This means: an extra fstrim (via btrfsmaintenance script, etc) is
>>> unnecessary?
>>
>> You need only one service, either from the fstrim or from
>> btrfsmaintenance.
>
> Dennis’s async discard features are working much better here than
> either periodic trims or the traditional mount -o discard.  I’d
> suggest moving to mount -o discard=async instead.
>
> -chris
>
> Apparently, discard=async is still unsafe on Samsung SSDs, at least
> older models. I enabled it on my 850 Pro, and within two days I was
> getting uncorrectable errors (for csums). Scrub showed 12,936
> uncorrectable errors.
>
> While I was trying to recover, a long SMART analysis showed the actual
> drive to have no errors.
>
> Then, the first recovery attempt failed. I had deleted and recreated
> the partition. When I was copying the backup snapshots back to the
> SSD, uncorrectable errors showed up, again (4,119 of them after
> copying one snapshot). I then overwrote the partition with all zeros,
> and when I copied the snapshots back to it, there were no errors.
> After recovering my filesystem, scrub still showed no errors. So, alls
> well that ends well, I guess.

We’re using this on a pretty wide variety of hardware, so I’m 
surprised to hear this.  Are you able to reproduce the problem?  Is a 
periodic fstrim still happening?

-chris
