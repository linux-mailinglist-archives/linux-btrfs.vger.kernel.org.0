Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2B63FD0E5
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 03:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241667AbhIABsZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 21:48:25 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:54654 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241643AbhIABsU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 21:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1630460843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjNnydIhpz5jIa/urTMQ7CW4WKp1oD3cEPW5cYbGJYg=;
        b=OmB382JR5WiFC+G+FL1NAzPz5I+kz6GrXEOVzMm83G3G4+9ey8wj5win85BxDP3F017Qm5
        AKrkuWObWDVNacb9gnTNBasNMeBxqwLGrz1E9f9elOdJ6bpXoVpTcKDnEWLEpVd8IMUtCM
        UzUdJbXd309d8hgF9uc3Ro/Q0OW9Nnc=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-XQvbD2gHNhKWWFy2TQlqnA-1; Wed, 01 Sep 2021 03:47:22 +0200
X-MC-Unique: XQvbD2gHNhKWWFy2TQlqnA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2QlZe0EgSduQT6al6yEKc8Z64Qf0bJxkMbcOOQBh/1w6CSnLsUn2nGTBmIqAzSf+zBA1lJyqfplXcLwoyELmastBJC4k1s7zwUWjbuWgcljq8WO7J5wK54eHeVijEDVxK7V+y/INfMlUiGbaaH1jXv5QQ9qcwo121fyqE9gEMrRn3NvDdM27/DXCG4u2qcQBpuxp1Q43x4nxEAeGsn/IynSg05x3kckwYp4PSXRsDsvWIPCTqaFE9axCS3AsiBbMNJRQlfj4CqnqDqaj4h/aqeRegavl4QBpQnJvv7bpawmGwgcGzKLosgezjzhE71ZVdbGqiwa1KwWtPUYad8F/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgsScoCzvmRvJqEqATPwUZmoT/PSXYpzu66FrhPIWD4=;
 b=NXRqAUoWeaCKy+wx2FUiydn3z7gYfE6ynWZY3+GAV3tvsaUwXE453x/sfaga4gmt8ZFAX2ZeVU5sb1zmh6OQYhDE1JTrh+8Aa/tvk0xllxlwqUJE+PtyccSA5ZTITjsaUzDPoHth1yYuRNzkR+8wEsNC2ISeR0rDrVQ+AimLInBKmWVCDU5Ob+CvkBKI13TyW3foMLxxQYn+UKB1DJk2cI6U8WtvcEWw+Xg8lTZsDmHl0+Xu7jz45F62Y49JiNmUxf0AjziBfNT5iUdWHHKxHOS5GH3cz1G3N4LssPOa2no395ob3jBTLXFV4JC4DfPj+Li0JZqDD4P6HCGEyyq9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4039.eurprd04.prod.outlook.com (2603:10a6:209:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Wed, 1 Sep
 2021 01:47:21 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%4]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 01:47:21 +0000
To:     Konstantin Svist <fry.kun@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
 <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
 <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
 <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
 <60a21bca-d133-26c0-4768-7d9a70f9d102@gmx.com>
 <7e8394c9-9eb3-c593-9473-5c40d80428a5@gmail.com>
 <1785017b-e23b-e93d-5b78-2aa40170fe62@gmail.com>
 <14a9a98c-50fc-eb7b-804b-2fe36775b5fa@gmx.com>
 <36652872-850c-fe92-9fcd-c9c95dc25d65@gmail.com>
 <cebedd98-1fe4-731f-fc54-5366c8f18a2f@gmx.com>
 <d0ebdff7-10f0-c8f3-e098-18f651a149d8@gmail.com>
 <597bd681-c7ba-075c-4376-142695b91f93@gmx.com>
 <4a5d64fd-637c-bd8a-fe6f-db1bb20942c2@gmail.com>
 <5858520a-ca82-0552-140d-9702fc7dad94@gmx.com>
 <74809aba-047e-ca7a-e5b4-d64287ddd81d@gmail.com>
 <3fbd1db5-97f7-8d8f-e217-3a7086eb74b0@gmx.com>
 <aa33b83f-b822-b1d8-9fe4-5cf4ab45c3e1@gmail.com>
 <64eb1b22-a9c0-e429-4407-cdfd6af4e031@gmx.com>
 <dc35d674-1dd8-d67a-0e78-b38bf1a638ca@gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Trying to recover data from SSD
Message-ID: <dd93028b-f846-6791-f12c-9d77ed4b242d@suse.com>
Date:   Wed, 1 Sep 2021 09:47:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <dc35d674-1dd8-d67a-0e78-b38bf1a638ca@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0169.namprd13.prod.outlook.com (2603:10b6:a03:2c7::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.11 via Frontend Transport; Wed, 1 Sep 2021 01:47:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c0830d5-ef3a-4e96-9a7e-08d96cea702a
X-MS-TrafficTypeDiagnostic: AM6PR04MB4039:
X-Microsoft-Antispam-PRVS: <AM6PR04MB40396A624556FE985AE71501D6CD9@AM6PR04MB4039.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TH+FKTTfWMnketH/V/X9BvF8LXnV8hlv2Npx//o0wxJPVpUs4gcGoGGzGjBRX+ACJqOdSJGFt6Z1xlRjIKNa0CB4+Z8AnLOf47NpGK39YquM6HXMAU7bF9yOpiBsKi6AX4azQJijKThZUISzFxUo6drLYIjG10csYnPpi8qwwoPjGF3LN35NHBI3WKlOlwCCb0/TV4fTzcyKryfCw7FVcCZf1h+/6af+sAQHv/0JJhc6rCWw0oTy+/+H2h4SM+6cfQcfJx+zAS/75HOVhaQ8hk4Tz5dqWwhidb8QsILamDWvGRJuH0fpW1j1Y8CP4FTfv0UHkRjo8qJk3Ab0co2H8gTEIELyPfzezHDKjP2Z1SHBxVwFi72CRiPrpDt0Au1M85m3SUY2tnEhzyv7dP8ZcAz8+CGOyOfxlcK9CwlSiJuVzDHCR/w2eIrsdT8AkA7tc501ZOsZG7KkIgWR3zZz0bpa4F0dLh4KrAN1cUpbJFDxMXO4T0Eulyj7tbsFTkJGT1tXL6b09Zk7Qw71SJDB9KhQHTvuktZkBAFSXcVQ1m0hWb9NC5Qi6MqEf7LIGxDv0x1q1uve9IxdvXpGGUbIiUIWoXlNeAMJ7DIb08ngorCMyxZr1MgIDwndCNHLfXeFYWhTlQ5TwWEo19wMvw5APaXfniYvEaRGuVGkgEAnyhEa67lgTfSMiHH5l03gp7ul8zpp4AG2x3HKIGuvfQ0uPnIxjQL8k08BdZwOeAXaPxJyHmee8s6eHX1I+p5ekvd9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(396003)(39860400002)(478600001)(186003)(31686004)(66556008)(316002)(6706004)(31696002)(6486002)(16576012)(110136005)(53546011)(8936002)(8676002)(5660300002)(83380400001)(66476007)(2906002)(956004)(36756003)(2616005)(26005)(86362001)(66946007)(6666004)(38100700002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QuKnpVjtdm9B0NNCKDFE2DfIAoCL5iatiOQyYgKSdfaurU0jUX0AiOv3lPjm?=
 =?us-ascii?Q?ZjRGz/+GxprOJLIDuqlwDpqaFedV99NqT9kTwXNjl2RVhwSbnz4Ig9uF++vm?=
 =?us-ascii?Q?LeUx4bKu+7bI4GMGXXQmIHKLuKLlbHxiqw/f6O1xV1E/gR4S+eXNuD7ylHBg?=
 =?us-ascii?Q?r9I0FIf6Hndenex/3Fl8HAlCbHXchKQsE+Ub7oo0flPkqnvEGUisRs4wlPQe?=
 =?us-ascii?Q?mH68d2SXfp9ubJ33g78KGtnGJ+IEurhLIFI7HI8IFnVXXcuwSBFUHOkE9WG2?=
 =?us-ascii?Q?bPaR5eB6U2nvXhdwsBN1WgALI2kbFEUUDVysny6n/XOuRv45BV3zmDywyAHm?=
 =?us-ascii?Q?+4FmNW3i1pH00YXw9gVUe13LIwJMNbLML4QC1oHNgJqmwPTHwcvJMz8AXv79?=
 =?us-ascii?Q?HSv4hB4xy4kaUB+HfEtrWR0GgYhsxgh+JQglC9qM4trtE3qHGpabfzaaPU6G?=
 =?us-ascii?Q?2nHWTaKa9ixxzgNcd+bQ7O6W09NWcpfiVJ6J/Sj3t/AeXrMKJ7asjwbpRw24?=
 =?us-ascii?Q?x+yPTymDSvRplqrAtvf0odfPSyt9rnTWMGDDdlzd4kJix0vamih+N/KSDroY?=
 =?us-ascii?Q?yy6e7cue035/ZUa2eEcOdXr/FNuiDXGOS8bIlbrsSfrzXFnfuYCNhRwrulb2?=
 =?us-ascii?Q?ZOqVW+v2XAMCC8/k/z1nwA/Vfkn7Lbr6h2HFmAh20vL8g4rrJip1Mzke0cHW?=
 =?us-ascii?Q?05I6DEMnavwwdrDFmtpMn7wQAeHy4gE1t12S/auMgGpv2BiThSzscZq8JPGH?=
 =?us-ascii?Q?Kp7uMKx7s2HM055XGkVRNwfa/gDDca0qX34COcE+sRa3RLCty8dZFC/mYyKX?=
 =?us-ascii?Q?WOyCPaY/Nm9o02C4O9EmTck9MnYqe+/rAaauokPt8uzkU3agkFNBja//Gi/N?=
 =?us-ascii?Q?nKtvlJzd2RMLUI4ujO4uGNI77M6vR92KrKQkKJjGtueZYDAw6SGB5tu6rod6?=
 =?us-ascii?Q?3zg7K6indh9XlBdW5Zf2fyCZNrOqVVC6Ol6z9oM4vRAo2aHIoVOLIQ+a3E55?=
 =?us-ascii?Q?YeRKYdmJATKaxDQhEHXRn75sLIwa1PMgFtzOL5H35m3JsaYbzw8MX4uR1WsN?=
 =?us-ascii?Q?uC/7CZk56Xq5GcWOjhFK0+lkG+o9koGcQZoPY/JMGHFeZwtBLNuWszxibzX8?=
 =?us-ascii?Q?GwSbZOFeb+j2hbubTLGJFqfDk2PiW0lpYSMRre6dm2zzFg1JTBHz3Y7JL98n?=
 =?us-ascii?Q?SyStBftIRuCnko/7jj2Iaq0CusbrAcKRWv2JBtOEkogrSHVJhNfpgY0Y4OxT?=
 =?us-ascii?Q?MmFH1xEE4OjZjqG3Gg1QEP51sRIogsrHAF7uPsiRtH2SMucgPmOwdTkOektY?=
 =?us-ascii?Q?diIy3YarDToo9RqWMDWCrFx2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0830d5-ef3a-4e96-9a7e-08d96cea702a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 01:47:21.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPGclTlyf8o5HDsv2SPJvZlFS+BzMmOKkTMa/limKTsve4FLZr8OqvBAC1Jj2Y7Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4039
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/1 =E4=B8=8A=E5=8D=889:38, Konstantin Svist wrote:
> On 8/31/21 04:05, Qu Wenruo wrote:
>>
>>
>> On 2021/8/31 =E4=B8=8B=E5=8D=882:25, Konstantin Svist wrote:
>>> On 8/30/21 00:20, Qu Wenruo wrote:
>>>>
>>>> On 2021/8/30 =E4=B8=8A=E5=8D=8811:48, Konstantin Svist wrote:
>>>>>
>>>>> I'm hoping to find several important files at this point, definitely
>>>>> don't need the whole FS..
>>>>>
>>>>> So when I run this, I get about 190 lines like
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (256 INODE_ITEM 0) block 92074803=
2 gen 166878
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (52607 DIR_ITEM 988524606) block =
1078902784 gen 163454
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (52607 DIR_INDEX 18179) block 189=
497344 gen 30
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (174523 INODE_REF 52607) block 18=
5942016 gen 30
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (361729 EXTENT_DATA 0) block 7859=
07712 gen 166931
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (381042 XATTR_ITEM 3817753667) bl=
ock 1027391488 gen 120910
>>>>
>>>> Can you provide the full output? (both stdout and stderr)
>>>>
>>>> If you're concerning about the filenames, "btrfs ins dump-tree" has
>>>> --hide-names to mask all the file/dir names.
>>>>
>>>> 190 lines look too few than expected, thus means some tree blocks are
>>>> not read out properly.
>>>>
>>>> You may want to try other bytenr to see which gives the most amount of
>>>> output (thus most possible to restore some data).
>>>
>>> ## Naming these BTR1..4
>>> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root | sort -rk =
4
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=
=A0=C2=A0 787070976=C2=A0=C2=A0=C2=A0 gen: 166932=C2=A0=C2=A0=C2=A0 level: =
1
>>> ### BTR1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=
=A0=C2=A0 786399232=C2=A0=C2=A0=C2=A0 gen: 166931=C2=A0=C2=A0=C2=A0 level: =
1
>>> ### BTR2
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=
=A0=C2=A0 781172736=C2=A0=C2=A0=C2=A0 gen: 166930=C2=A0=C2=A0=C2=A0 level: =
1
>>> ### BTR3
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 backup_tree_root:=C2=A0=C2=
=A0=C2=A0 778108928=C2=A0=C2=A0=C2=A0 gen: 166929=C2=A0=C2=A0=C2=A0 level: =
1
>>> ### BTR4
>>>
>>> ### BTR1:
>>> # btrfs ins dump-tree -b 787070976 --follow /dev/sdb3 | grep "(257
>>> ROOT_ITEM" -A 5
>>> ...
>>>  =C2=A0=C2=A0=C2=A0 item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsiz=
e 439
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166932 root_dir=
id 256 bytenr 786726912 level 2 refs
>>> 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ### naming this RI1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 56690 byte_limit =
0 bytes_used 1013104640 flags
>>> 0x0(none)
>>> ...
>>>
>>> BTR1 -> RI1 786726912
>>> BTR2 -> RI2 781467648
>>> BTR3 -> RI3 780828672
>>> BTR4 -> RI3 102760448
>>>
>>> ### inpsecting RI2
>>> # btrfs ins dump-tree -b 781467648 --follow --bfs /dev/sdb3
>>>> RI2.inspect.stdout 2>RI2.inspect.stderr
>>> <outputs attached>
>>>
>>> One of the lines of this output is
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key (2334458 DIR_ITEM=
 3564787518) block 196816535552 gen 56498
>>>
>>>>> I tried to pass these into restore, but it's not liking it:
>>>>>
>>>>> # btrfs restore -Divf 196816535552 /dev/sdb3 .
>>>>
>>>> Where the bytenr 196816535552 is from?
>>>
>>> ^^^ output from inspect RI2 -> DIR_ITEM. Probably wrong usage? :)
>>
>> OK, that seems to be out of the way btrfs-restore can handle.
>>
>>>
>>>
>>>>
>>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b=
6
>>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b=
6
>>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b=
6
>>>>> Csum didn't match
>>>>> WARNING: could not setup extent tree, skipping it
>>>>
>>>> This part is expected, it just tries to read extent tree which is
>>>> manually corrupted.
>>>>
>>>>> This is a dry-run, no files are going to be restored
>>>>> Done searching
>>>>
>>>> While this is not expected, as it doesn't even show any research
>>>> attempts, is the bytenr from the subtree of the subvolume 257?
>>>
>>>
>>> Interestingly, I tried --dfs instead of --bfs and there are a lot more
>>> entries, including filenames
>>>
>>
>> BTW, thanks to the output and stderr, it shows exactly what's going
>> wrong.
>>
>> The offending tree block, 920748032, is the first one.
>>
>> If using --dfs, it will go through each child until reaches the leaves,
>> before going to next tree block.
>>
>> And if the first child is corrupted, then it gives up immediately.
>>
>> That's why I'm explicitly specifying --bfs, which will skip the
>> corrupted child (and its children) and go next tree blocks directly,
>> thus have the best chance to recovery the contents.
>>
>> For the worst case, I guess you have to use "btrfs ins dump-tree" to
>> recovery your files, and then "btrfs-map-logical" to grab the data from
>> disk directly.
>>
>> Meanwhile I guess I should put some time to enhance btrfs-restore to
>> handle the corruption you're hitting, so that we can continue to next
>> good tree block, without being bothered by early corrupted tree blocks.
>=20
>=20
> Thanks again for looking into this!
>=20
> Should I wait for a patch or is there something else I can do meanwhile?
>=20
>=20
Yes, you can use "btrfs ins dump-tree -b <bytenr> --follow --bfs" to=20
dump the tree and look for the desired files. (aka, manual salvage).

The filename is included in INODE_REF key:

         item 55 key (258 INODE_REF 256) itemoff 11848 itemsize 15
                 index 3 namelen 5 name: reg_0

258 is the inode number, which can you look for its data using (<ino>=20
EXTENT_DATA <offset>) key.

         item 56 key (258 EXTENT_DATA 0) itemoff 11795 itemsize 53
                 generation 19 type 1 (regular)
                 extent data disk byte 13697024 nr 4096
                 extent data offset 0 nr 4096 ram 4096
                 extent compression 0 (none)

Above (258 EXTENT_DATA 0) means, inode number 258, file data at file=20
offset 0.

The logical bytenr on-disk is 13697024, size is 4096.

Then you can go "btrfs-map-logical -b 13697024" to find where the data=20
is on real disks, and use dd to grab them and assemble your file.

It's time consuming and only feasible for a dozen of files.

Thanks,
Qu

