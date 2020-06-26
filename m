Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859F620B630
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgFZQsK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 12:48:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27132 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgFZQsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 12:48:10 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QGhE26016995;
        Fri, 26 Jun 2020 09:48:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=L75YK0qB5py6EjReUZ4kW/t+BaQIUor58z48aVnBdfc=;
 b=MqE27i6bRJRxktFB9SDCIXBhubcB4JpL0OEXnR5krMaFjvc//067kenTMSmvneus6P87
 6h+nDQfBtk0vyf9bya0gCzJaAKgcryyRkVdww6wNVDHJLLlA8VzEZxeE/UIgYtallQNq
 Cq1kIG2ERbfVaijSWic1bYjtrK/YviidauI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31ux0u680e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Jun 2020 09:48:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Jun 2020 09:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KffSHACGQTqd7bRwdLUYLcFAaiZmAfg73WLc2azM84sDIycnvPlqVxLFV77aav3+Orm32LbgOejdXwSoAsCGsca9SgJB4rxQFu9eYz8vuEzy69u42lZeswtBlylFCmcFIEDvprJ212j1ugCESCI7FedS6Kr7zmD3mUENuV3ydvYogT+pG3qREB8f0MoUAxlp192RvTWPaUHLenQfddpAYXZfOOznVZ4ponZzPSRTnrMGnAacbYnZAmxFOs8buCjdh9Xu8e54LlZ1UDiJ5kguzIZvRoPR9Qq0Fk6cS1333J6m+/Jnd958r9fVw/qPEsc8mUZVhz1R9wSQtuU2OukqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L75YK0qB5py6EjReUZ4kW/t+BaQIUor58z48aVnBdfc=;
 b=BHouJ+5JFKgFCipDHeLEhZgcM3Jrv+dPSbwY/1r+JXIl0IQJ7JdDopTaDQLD8swiGUJ2KYO1xDnPCm/5XrhoSggUm7mA1/C6pY8j7L8sE6MV/fqYoyrT27OfNTYxmxIXKZBbpVKAUzwna2FwJ/i3Zl3kEFHILirjGb8xLNsp9AAcyRUirf1BmsaQd6++GdkJeTfoHnrbMkWA6D0tUQavk+cQbowouiw3wGa0CYaDVjm7DBipaqatUI9NYA7MR+dtKjT4mkeeC5Ye43zwyTkW50CCy/SMWBpfM0JNcG5T1oGeaJUUx9V9sRxMTplJr4lrhqIp0BYbRvqTxSt7y0BsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L75YK0qB5py6EjReUZ4kW/t+BaQIUor58z48aVnBdfc=;
 b=bqZ7cwmQy2MTFxYY5XOg46K3ODug88iiArL69nFvlzLXW9blrhESRyWQi+HJ/Tn/84F9rAmC9HXWHVPRoB+N7+PlSdoLXKdXXawSTC2lRSAFZ8kAVSLjLLJTj5NHrLFvNOJs7rKLZXyj+s8ikbevxnfFsN8j4CfWphrTLCh2mR4=
Authentication-Results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none header.from=fb.com;
Received: from CH2PR15MB3608.namprd15.prod.outlook.com (2603:10b6:610:12::11)
 by CH2PR15MB3734.namprd15.prod.outlook.com (2603:10b6:610:9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Fri, 26 Jun
 2020 16:48:04 +0000
Received: from CH2PR15MB3608.namprd15.prod.outlook.com
 ([fe80::5800:a4ef:d5b3:4dd1]) by CH2PR15MB3608.namprd15.prod.outlook.com
 ([fe80::5800:a4ef:d5b3:4dd1%5]) with mapi id 15.20.3109.026; Fri, 26 Jun 2020
 16:48:04 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Chris Murphy <lists@colorremedies.com>
CC:     Tim Cuthbertson <ratcheer@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: weekly fstrim (still) necessary?
Date:   Fri, 26 Jun 2020 12:48:02 -0400
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <C09CB322-1DEC-4B08-A706-D49AF679302E@fb.com>
In-Reply-To: <CAJCQCtQQJkwB-Yt+ogQUXSZLVxNzTWw0voorALSwfKLXBz7pHQ@mail.gmail.com>
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
 <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com>
 <CAJCQCtQQJkwB-Yt+ogQUXSZLVxNzTWw0voorALSwfKLXBz7pHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To CH2PR15MB3608.namprd15.prod.outlook.com
 (2603:10b6:610:12::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.13.224] (2620:10d:c091:480::1:c29b) by MN2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:208:134::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 16:48:04 +0000
X-Mailer: MailMate (1.13.1r5671)
X-Originating-IP: [2620:10d:c091:480::1:c29b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d823e8a-388d-4b7d-d422-08d819f0b248
X-MS-TrafficTypeDiagnostic: CH2PR15MB3734:
X-Microsoft-Antispam-PRVS: <CH2PR15MB3734E387BECDBDEFD863825ED3930@CH2PR15MB3734.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDIigMaXkypliaI+EVWksczPcP3z8cZT41cP5EULBjNFqcbo1OTDjHOWtNYxvcXFl9pvo1saZlLBniblLzBVvnYdntylURE5ty05C2nNdmV3Q3Ca/URSqgrPRXWmi2NEqJZ9QySns3Z36c2Pqg5Z1l+k3cEq50eJxGCiGM/LMACW4iuhToL7XnOUDgEQr/RqIGX7zaJS/I4jHj0767mrmoc1EBdKX4Jlydt2LvSPcXam5pza4sgUlqJ6O2zsskT2gACWz3Ie6IfGWvX6RC2HZd7ZYEOnD2dyTBt/FgAi45oGCCcPBeZB1V26iaC/v9P665m7+uNAttcRWwwF+6Ez/QUNsF0PWvz77OMNiHb0mX5n37A3lUKcGsHr66Oju7cYqb93J42ddEsH6dCvRNATxIGIFZ1+JJJ0ySXolqx3iCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3608.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(136003)(376002)(346002)(396003)(8936002)(36756003)(53546011)(66556008)(8676002)(6916009)(4326008)(66476007)(83380400001)(33656002)(54906003)(316002)(66946007)(5660300002)(86362001)(2906002)(16526019)(186003)(478600001)(6486002)(956004)(2616005)(52116002)(78286006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wkeTG1d+0ZH7t6aCr1e3esw5xY++xUBdpKeyCxcPstAer+FbOE1aPpeUPTR6BRti5Gk0Ys46Hfrx1g7mC3kKPEWneyA99ktETCGgLzJzsVgxl4y5Uue+2rZe6CwIeD/lMViNB1aKqkElLeLxP4OGN1TVw86ZGcUsQMeUlZ/OdWNdrIoG6ZrirTLLJbybrL6HJTlgUQCPV/Z/Y4uTPXDrr4rjVR/4p00VdDMdkSFDs716FUuKYn8MF9EK+aby5gPf7AqT3cm5bEWBheSb84Zunth7yiIvmjf1ZYUtfQUNbMvodEsydXyGZJtFb3gYeZvDkYXDOV1sbIKkH3A9WAQAzpqCmsqNhpZkN8QhnaoHKCOZwtwy4wKLDM1gxl6dCwXpwuBP2ER4LWWZL33JLhq9rO3Y8Kqt19e7UUemjoyiM1xXlGJNMukj49g8hzqAD0s+Dz5MaHKSCXCX8AHWMDPdx631sMXftH41kpv6zhKd5oryVhdWLJHv5igmnnMpyHg2oxUmqnO2I5fH4Z/VrbouwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d823e8a-388d-4b7d-d422-08d819f0b248
X-MS-Exchange-CrossTenant-AuthSource: CH2PR15MB3608.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:48:04.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGVAhEIJEX/+xV2cHU+VCWwnideFe2FUZregYJt/jZz/fb1FU38oaj5pCkHQwUf8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3734
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_09:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 cotscore=-2147483648 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260117
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26 Jun 2020, at 12:40, Chris Murphy wrote:

> On Fri, Jun 26, 2020 at 9:40 AM Chris Mason <clm@fb.com> wrote:
>>
>> On 26 Jun 2020, at 8:08, Tim Cuthbertson wrote:
>>
>>> ---------- Forwarded message ---------
>>> From: Chris Mason <clm@fb.com>
>>> Date: Mon, Jun 22, 2020 at 10:57 AM
>>> Subject: Re: weekly fstrim (still) necessary?
>>> To: David Sterba <dsterba@suse.cz>
>>> Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
>>>
>>>
>>> On 22 Jun 2020, at 10:23, David Sterba wrote:
>>>
>>>> On Mon, Jun 22, 2020 at 04:02:34PM +0200, Ulli Horlacher wrote:
>>>>> On Sun 2020-06-21 (18:57), Chris Murphy wrote:
>>>>>
>>>>>>>> You need to check fstrim.timer, which in turn triggers
>>>>>>>> fstrim.service.
>>>>>>>
>>>>>>> root@fex:~# cat /lib/systemd/system/fstrim.timer
>>>>>>>
>>>>>>> root@fex:~# cat /lib/systemd/system/fstrim.service
>>>>>
>>>>>> I'm familiar with the contents of the files. Do you have a
>>>>>> question?
>>>>>
>>>>>
>>>>> You have deleted my question, it have asked:
>>>>>
>>>>> This means: an extra fstrim (via btrfsmaintenance script, etc) is
>>>>> unnecessary?
>>>>
>>>> You need only one service, either from the fstrim or from
>>>> btrfsmaintenance.
>>>
>>> Dennis’s async discard features are working much better here than
>>> either periodic trims or the traditional mount -o discard.  I’d
>>> suggest moving to mount -o discard=async instead.
>>>
>>> -chris
>>>
>>> Apparently, discard=async is still unsafe on Samsung SSDs, at least
>>> older models. I enabled it on my 850 Pro, and within two days I was
>>> getting uncorrectable errors (for csums). Scrub showed 12,936
>>> uncorrectable errors.
>>>
>>> While I was trying to recover, a long SMART analysis showed the 
>>> actual
>>> drive to have no errors.
>>>
>>> Then, the first recovery attempt failed. I had deleted and recreated
>>> the partition. When I was copying the backup snapshots back to the
>>> SSD, uncorrectable errors showed up, again (4,119 of them after
>>> copying one snapshot). I then overwrote the partition with all 
>>> zeros,
>>> and when I copied the snapshots back to it, there were no errors.
>>> After recovering my filesystem, scrub still showed no errors. So, 
>>> alls
>>> well that ends well, I guess.
>>
>> We’re using this on a pretty wide variety of hardware, so I’m
>> surprised to hear this.  Are you able to reproduce the problem?  Is a
>> periodic fstrim still happening?
>>
>
> I'm curious if there's a possibility of confusion/conflict between
> scheduled fstrim combined with either discard or discard=async.
>
> As in, if it's a big enough concern, maybe the scheduled fstrim needs
> to get smarter and parse mount options, and automatically deconflict.

It should do the right thing, any conflict there would be a kernel bug.  
But since we don’t do fstrim here, it seems like the mostly likely 
spot a bug would hide.

-chris
