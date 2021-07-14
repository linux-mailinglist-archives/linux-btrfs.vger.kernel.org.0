Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70BD3C84ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbhGNNFD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 09:05:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:46505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhGNNFD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 09:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626267727;
        bh=61wToHsiFCNgQHboLxtx9jaxZ8VOVvkHSyUVnzHEp18=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ka+T8MnaOG2KkNxpX051Cv7ThzLf/Ja4mjymr4vJgA9D6p/cuprqJNJWNaM617E3F
         I0UcYi7cbKu1ytmb/BzUXCpycK/SlHCPFtLNRJqw4YyYf4SD+MXcGemmMmamwOUG1F
         P+EgE8+4vjvAHl0D/rqrYmpUq5nXr5BGTAeXyNok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MlNp7-1lITPX1jvp-00llrp; Wed, 14
 Jul 2021 15:02:07 +0200
Subject: Re: Enhancement Idea - Optional PGO+LTO build for btrfs-progs
To:     Neal Gompa <ngompa13@gmail.com>,
        DanglingPointer <danglingpointerexception@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <d0f8f74f-edd3-6591-c6e5-138daf6b25f5@gmail.com>
 <f68a2809-eb46-744f-7045-93eaeb4bb44f@gmx.com>
 <db80b801-9e7d-ce2b-15dd-84b30faf19cd@gmail.com>
 <2a29adba-8451-7550-a6f1-835be431953b@gmx.com>
 <762a5060-e38d-ccef-293d-c05389d5b0af@gmail.com>
 <CAEg-Je_2rMu-Y_Qu0tvD85_jnSTGtvkZxE0d7VTASCxCBSdZZg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a5007cb5-c31e-5762-7f0f-b0930650e87b@gmx.com>
Date:   Wed, 14 Jul 2021 21:01:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je_2rMu-Y_Qu0tvD85_jnSTGtvkZxE0d7VTASCxCBSdZZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HueKPWI1LZGZCVXPzoNPSaD792GhIlJv3h2L26jKx9oLZwH4wjk
 USI84dTXSbit5msWLB+ybwIaybPTnT+9Q+e34M14apiwKnqYxo97jGNtS6X8LaDivY40Sef
 qWGItlqdQNdl7WV/qYIpQINpYCy0rxcmzi7heZvxLGpuDq7Zkuoq6Huhg6rXNt67dN7f8Mi
 F7J3Y0JLhpt24nKsV4jsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HSN5nRPmz3E=:OY0E90JicFM6EqtIcSAlQ6
 QwJRjQElFkaOifbiew5ExQRUL8kdTkE1n7nBebD67yoQKg5PxDM61uWZhsKy3sjzmBCskstGI
 Zi1lBT9GnqsMlQpbPZ1Enbkk8nrWkjeLmP49Wr2N3AdA7InWRCKyYirndhZjdGv3/lPUco7T+
 GvJBjS/MQJNFvBPkmpB73ilphxu3U5dSwul0i4JPVAP5cNHqv1N2Uuy1uNAXGDZbxKcjKZi0N
 apabQZoswHq4VjcNiIC4//Cue50rJu3FZMCw8so2WCuGHRbdvoRFH566Oq3B7fjcyqEm6crJ/
 GbznqHkxcVFFOdS7Rnie3PIaCClypgUWdwMJzxlceGRHV1mB8pK9gPt7eE5v0sssmqt5KBO+N
 zQb5A4nZPLlO3TNR5YBYg79K83Clvnd/ielhPwpdVpCE9jIbh9F9cMlNTBNKnZp8MoLmsOpL1
 R/DjyilMnvv/qrjFOXyJrz02TQsnvDa1nWJ6p1MJGjZBk830aHZ6n/X7aOX9KhMcb/xjvMUL/
 HdExSeiVZSbfnPQDpOFpswHpmYb2+AEg54hAFqf95dtTwmZoHTKu1+wyYu1fi+K+otjHi9rlc
 BFidJyr4W4GUQi0GOcT2To3YyAN4UCze1Mp4tk9vjDslfgLIUNbxniX5QYgEFY/ptneS4gK7F
 q6mgOjpVqKku8RWAP4DzNYZaojVdev1TImXyw/OK4vh1ObHUrl0D+Oioe1ohNfdZNF7iO9cDk
 P5O5V62IrMBx1HCrLWDjz4lpu+hQ1toJ9EhryUn2Uml8ehOBL4y6BtXU9uQYdVckshoX+JF8a
 XORj7j84PCV8kWLpw4z877iCXKV9zIfSgWA290+q+EwqeQ1jymXHIFN+1xYq1LcaqWKr0mJwX
 W/tfdwIUSsv3sWGSS2saauMGaqlt1Vh0pR0etv0sQ8CxXIHWkMNkSp6sYkU7QUKS+25Qz2qu1
 HDgXKp+Y7pguF0D28qv88X/ZcbYO+bg+6QNDdNAYpNWraR+3o9dwemln9m+/QnXCAIMr16ql0
 MLdn5ZTROWVdsX6BJjglBy3IUWh/lzjovYNm2Nmsl4K6XKIremGwiEQhWxikVCkMAwqgJE336
 h1qJlRTNrie+Qg+vwI9twHc9JsQUbmpNKiXZ32xlq+dS5DPhifxIn2IgA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=888:35, Neal Gompa wrote:
> On Wed, Jul 14, 2021 at 5:22 AM DanglingPointer
> <danglingpointerexception@gmail.com> wrote:
>>
>> Yes noted.
>>
>> We're aware of the write hole risk.  We have battery backup for both
>> workstations and automation to shut it down in the event of power-outag=
e.
>>
>> Also they are lab workstations. Not production.  Data is backed up to
>> two locations.
>>
>> The primary reason for RAID5 (or 6) is economics.  Money goes way
>> further with RAID5 compared to other RAIDs (1,/10,etc) for the amount o=
f
>> data store-able in an array with the reliability of being able to loose
>> a disk.  I'm sure there are thousands of others out there in a similar
>> situation to me where economics are tight.
>>
>> Would be good if at some point RAID56 can be looked on and fixed and
>> further optimised so it can be declared stable.  Thousands of people
>> would further flock to btrfs, especially small medium enterprises, orgs=
,
>> charities, home users, schools and labs.
>>
>
> Btrfs RAID 5/6 code is being worked on[1], so this will be fixed
> eventually. I personally look forward to this being resolved as
> well...
>
> [1]: https://lore.kernel.org/linux-btrfs/BL0PR04MB65144CAE288491C3FC6B07=
57E7489@BL0PR04MB6514.namprd04.prod.outlook.com/
>
 From what I know, to solve the RAID5/6 write hole, the real solution
will be a journal, just like what all other soft raid56 does.

This means, we will have a new RAID5/6 profile other than the current
non-journaled RAID5/6.

Existing users still need to convert to the new profiles, not something
will be fixed magically.

Thanks,
Qu
