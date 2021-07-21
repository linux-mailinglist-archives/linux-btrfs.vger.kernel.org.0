Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8764E3D068C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 03:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhGUBMj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 21:12:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:53025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhGUBMf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 21:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626832384;
        bh=aJMnJnL7RMRt2BU5DBY+5U1tYFOAJAD4qJ+6LIl0Img=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=LGBXf+WovPFD8zd6XrLjIKecqGIj/7mHylizrPTI0i0np5gBouU70MBqhFohw6YTZ
         VUz7bfkdgKA3OJg7GZAfDiEBfKNpNmmtoRx5RzvjUAr/l3V6ywPuZ9JdpxCbuz8KZi
         0lIb63C2KS2lIEELPImiY3gIpU8vvz44zO+I1w2M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1poA-1m8DH52NmS-002Ccs; Wed, 21
 Jul 2021 03:53:04 +0200
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eryu Guan <eguan@linux.alibaba.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com> <YPbt2ohi62VyWN7e@mit.edu>
 <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
 <20210721011105.GA2112234@dread.disaster.area>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <ff57f17c-e3f2-14f3-42d8-fefaafd65637@gmx.com>
Date:   Wed, 21 Jul 2021 09:52:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210721011105.GA2112234@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KyZwI0aScMkH8anHfHEKDDi0zz1hBiF9tooXPJTiy+p/yhyl4Lj
 iFVvM3sQgAfn+Cf8Y7kIHMI+tF/Ia/z/ius1QGtlRZjrhb/UnWhak6ICnxfI1jX3dbLqxGt
 4GZRH8ZMUZVS9S4KOmmgGqXg+SxmDcoud3nFRnYPwfKUZ5R2YKpRsI/Xewg9U0WCSJewuep
 ZnZbQ9XzjTI5a2cCxp77Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+09Xf2+HCzA=:rAqURKGSwd+VvjmQITA6Dn
 QzzOTPFL62bwOYdsw+7EqiDmsJctpylBqym0P3aDd+M+3J/ADvPkbdTRzk9CiTenFAgBJzexS
 m++jPVTa6q9WbCjbrPnp5QGe2edtznNDCzsZ8XqSQG0Eui5K60F8D2ZLMUgF7x+iuuy4mIyNv
 cQcqo6Yg3oPFWdRTW23qN4fwB7TdxpyFYekoV/6OFS6wEUM48C/K5X1Jkc8kkYF6ILynuYN8n
 1fBoSAmzYKrrbBcPhgxoXjiRmdmASbq1YPk4jWoeQnC3T7jPRuftZEdLGG/1k+Td0uKE7Zevu
 Az6yjX6yhvvNJLeDd0yECLA7lvYm2sSvBGQkeidh+U1PCTiMRCD+iNvwWJrEP3Na1L2zPIHQJ
 lwHvnzFYMJSfTDiIyO+6qj+c2e2jqvS7br+RwI0uQFJk7y6t+c76mB8OOfZe1R3vI427eYgFD
 kkDxFGxcPBW91gUMqE/9UVSnjQ2ygoDN4evXhkvE8bxfZ6CAE51Z2CEgVbkirEsQYsTEnp9n8
 DygyU9Wz006EtVTjc8nfYU9XtlObOs/IqVZ1eFuk9xJxEJ8DNPG3bBIEJh6M/a7/Nvpol2Tx7
 SYXA9Smib8vq66pWJRRxGF7m2wkFFttzdcNYUq2rREip4Xwsyc7dV0l6eFA24hbaePlIsUaz8
 Yh8dL2hAwsZK2hlM7mg+EZuSZuLSqcroMN2vHusTuU4Sfrj88R+V1M56aoOkykjdyUrgnP9ea
 uwplRROKTId+kofC4xBRN2tS9tPJNVz0w2vRQ9JlQVoSJ3xw3c7YX/VngHeDinxyv96QoSYSo
 LSjUhxTqTmS/iPccIQhu7pybGvbXKFefjrKx2Xy5N0Bhkh5aiVLs0SsXSWyd5xK6yP9aWrE3M
 aIPv7O/O3BBmIwtSjabj7fWo9ZDIJdRsoUC2xLUfIv7DrX+rCRTJ99N837mqktCJy1DuWbxJ2
 Df7PQW6A3b7T5HDVFuLNDnXAzoBdcFi83zsKKB6vFZYwTA/sx1xGDCCHffEi7kOemAHuPYIM3
 kaZl6//JllFH3axMpTphpQNuw3hPQ/URnjJ6APy69dyjMbFcfFoGtmtVIU3/RfTiJcf7LjcIV
 J6lAeicq0KPrab8DVnqJHYLm5uANmmFlDf7mwbpNitAEJbDFUjKLVOZGg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/21 =E4=B8=8A=E5=8D=889:11, Dave Chinner wrote:
> On Wed, Jul 21, 2021 at 06:34:16AM +0800, Qu Wenruo wrote:
>> I would no longer consider to upstream any simple debug purposed code.
>
> Qu, please stop behaving like a small child throwing a tantrum
> because they were told no.

Well, if you think so, go ahead, no one can change your mind anyway.

>
> If there's good reason to host debug code in the fstests repository,
> that's where it should go. See the patch I just posted that adds a
> dm-logwrites replay script to the tools/ directory:
>
> https://lore.kernel.org/fstests/20210721001333.2999103-1-david@fromorbit=
.com/T/#u
>
> This is really necessary to be able to analyse failures from tests
> that use dm-logwrites, and such a tool does not exist. Rather than
> requiring every developer that has to debug a dm-logwrites failure
> have to write their own replay tool, fstests should provide one.
>
> That's the whole point here.  I could be selfish and say "it's a
> debugging tool, I don't need to publish it because others can just
> write their own", but that ignores the fact it took me the best part
> of two days just to come up to speed on what dm-logwrites and
> generic/482 was doing before I could even begin to debug the
> failure.
>
> Requiring everyone to pass that high bar just to begin to debug a
> g/482 failure is not an effective use of community time and
> resources. The script I wrote embodies the main logwrites
> interactions I needed to reproduce and debug the issue, and I don't
> think anyone else should need to spend a couple of days of WTFing
> around the logwrites code just to be able to manually replay a
> failed g/482 test case. I've sunk that cost into a simple to use
> script and by pushing it into the fstests repository nobody else now
> needs to spend that time to write a manual replay script.
>
> If we apply that same logic to debugging hooks and the scripts that
> they run, then a hook script that is useful to one person for
> debugging a complex test is probably going to be useful to many more
> people. Hence if we are going to include hooks into the fstests
> infrastructure, we also need to consider including a method of
> curating a libary of hook scripts that people can just link into the
> hooks/ directory and start using with no development time at all.
>
> You need to stop thinking about debug code as "throw-away code".
> Debug code is just as important, if not more important, than the code
> that is being tested. As Brian Kernighan once said:
>
> 	"Debugging is twice as hard as writing the code in the first
> 	place. Therefore, if you write the code as cleverly as
> 	possible, you are, by definition, not smart enough to debug
> 	it."
>
> Put simply, anything we can do to lower the bar for debugging
> complex code exercised by complex tests is worth doing and *worth
> doing well*. Hooks can be a powerful debugging tool, but the
> introduction of such infrastructure needs more discussion and
> consideration than "here's a rudimetary start/end hook for one-off
> throw-away debug code".
>
> Most importantly, the discussion needs a much more constructive
> conversation than responding "No because I don't care about anyone
> else" to every suggestion or potential issue that is raised. Please
> try to be constructive and help move the discussion forward,
> otherwise the functionality you propose won't go anywhere largely
> because of your own behaviour rather than for unsovlable technical
> reasons...

I'm pretty clear about the hook I supposed, it's not for stable ABI or
complex framework, just a simple kit to make things a little easier.

The single purpose is just to make some throw-away debug setup simpler.

Whether debug tool should be throw-away is very debatable, and you're
pushing your narrative so much, that's very annoying already.

You can have your complex framework for your farm, I can also have my
simple setup running on RPI4.

I won't bother however you build your debug environment, nor you should.

Sometimes I already see the test setup of fstests too complex.
I totally understand it's for the portability and reproducibility, but
for certain debugs, I prefer to craft a small bash script with the core
contents copied from fstests, with all the complex probing/requirement,
which can always populate the ftrace buffer.


If you believe your philosophy that every test tool should be a complex
mess, you're free to do whatever you always do.

And I can always express my objection just like you.

So, you want to build a complex framework using the simple hook, I would
just say NO.

And you have made yourself clear that you want to make your debug setup
complex and stable, then I understand and just won't waste my time on
someone can't understand something KISS.

Thanks,
Qu

>
> Cheers,
>
> Dave.
>
