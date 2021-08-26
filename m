Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE93F87F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242469AbhHZMvT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 08:51:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:36515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240886AbhHZMvS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 08:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629982228;
        bh=lERExQTpvJUt4SvDHTkZz6HdionPNv/7mVfnlkjQd4w=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gMzYhSmWp6DzHZ0IUvK6TRheZzwnS7FycB8JZLaQRTi9H4dNIyG2IBMCzO0FAY9/4
         01oRh9ChO5Snnt8XXdZF5EzA9NGjDUpTz7rdN2wMxXf4xU48KKakk6QHqaOfo+QY9U
         nC1FrNU7q/O9RaiacJbW9Fi5D/qEkPQRrUAUnceI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M4s0j-1mHJA43sYB-001xVj; Thu, 26
 Aug 2021 14:50:28 +0200
Subject: Re: [PATCH 0/3] btrfs-progs: check: enhance the csum mismatch error
 message
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210826064036.21660-1-wqu@suse.com>
 <20210826122815.GL3379@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6380b407-36ff-1730-12f0-8dc8248dcf2c@gmx.com>
Date:   Thu, 26 Aug 2021 20:50:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826122815.GL3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lNF22NKTcFD7bSaCd2KVvBTyeKHz59iXQWXyAI/gRL1oWrFhbZN
 JCFmoloE23nWSrIxIxdECohBWBoEB+7Bu6pErX2hbrahy1FZuVhljI/YY7PDDmIZfMspaMH
 9vncFD4k2LnVUYXri7mv+YwpbwZPKlksU1vLHPKO+bDY/7nzIlqJnKzYhlQ1cYGtsshWCMe
 x68IeiH/nfLwZqhjV45wg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w/78NLkCock=:0gnyjyCMa+jlQcPsCfnilF
 f2Fn/R4x3vqsSTo2cIqgrPCW3Rd9zrPsYQv/D9+xncB0g0ktLlUfPzge9Z/72WPimgTVlZZzc
 qxzN0LeGXcv8b8aH+P8Spd9kkikevFqcsT0veVFo7G10UTAaDQ2X99v5ZL+8UYnzr4wllj5wV
 sCoIWBNEQQiYVsUWsfekx7IPWsGj5bJxWGf0CE5I7XITorwyfEze7Keq20AeXsEvCM6WLIO1G
 BGYI2wp+T91KKbaB3/ZsHD8z+u+l4fLWAT9y06amDVGcpTliw7+y8v9YBHmXQ2lEImHxrWGFc
 KqJYeJwDOsBPEVLqyWHjngOOpAB6EEgUwcLZDeVpJX4gGFC3vJw7tN5Qeg+H159IhujlhNRDZ
 nrYaC0462KANBBf/2e2GgdiYkkdbn3Gs3TAQ/QFBsopcrrtmvy3hRW2VTb2xy6pfZY4ao9LOP
 Pmq5xlPsgycMJTpEXS2SM3uDQimiYYKbvwjHmJhmVWaE+Gm8Ue8Y8tA5wHgTvOdI0MF2Rugmv
 4FJGpAi2nVIL7cG9Ow4WYcFxkML50Mxa8/F/i/kgRNu0LJyfmnzUztuzFNJaaWd9HGWx/7noH
 C5wbumGuVZ8xF3P+wbrnjdkTCn9E+DOFp/S2zWsfEDVOFJOa4cM37dZ0GS1iAE6HAow3nU83a
 FTvXEfgQh+kz28sM606DLOApfwa8VIhL6iWdJ3nrJg/8xT+kCNMc7cf/AmPTTMkmXF9ytyJvL
 RZBlfmG1mn6L9zinrWXpBsgjDISgH2yMFYMwpyyN88SAyTCn+IfuBRnmdGRLWEx8Y2RcP9C9f
 1SxdspVUtO63a2MC9JaMx0q1Ar8Xe19tXEwyStCnmWHsescbx15JwfqLtcic/e8yxxIyX/KuZ
 XhFgigUhcdutpm6miTNSKYurfBbV9hjL9IB8BXdk1IUujdv0BYmoiSwBMXz58cBDVMxq1gNr1
 RKrXZdjjROG0+IUljQGkL/Vyc+ffR+J14o7tOInQ8ZSjKdpdkYV6Baqz3C+stKUiZQBcwcAT4
 5cC/Ekcl69J4FG23ZApRuce8AbVZKmxJGQxt78Ut3dffkdXkoiFOQ0LTFJ3GssGWy9sLUzn63
 GN8+5rf2yIBC0oJXgr1yASdfuuolxzCJfRLT2q85hlIfvuloAjYw4YUVg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/26 =E4=B8=8B=E5=8D=888:28, David Sterba wrote:
> On Thu, Aug 26, 2021 at 02:40:33PM +0800, Qu Wenruo wrote:
>> This patchset will change the csum mismatch error message for data csum
>> mismatch, from the old almost meaningless output:
>>
>>    [5/7] checking csums against data
>>    mirror 1 bytenr 13631488 csum 19 expected csum 152 <<<
>>    ERROR: errors found in csum tree
>>
>> To a more human readable output:
>>
>>    [5/7] checking csums against data
>>    mirror 1 bytenr 13631488 csum 0x13fec125 expected csum 0x98757625
>>    ERROR: errors found in csum tree
>>
>> Qu Wenruo (3):
>>    btrfs-progs: move btrfs_format_csum() to common/utils.[ch]
>>    btrfs-progs: slightly enhance btrfs_format_csum()
>>    btrfs-progs: check: output proper csum values for --check-data-csum
>
> Nice, added to devel, thanks.
>

BTW, the enhancement is just some fixes found when trying to reproduce
this bug:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1997477

If someone in the list is able to reproduce this strange bug (btrfs
check --check-data-csum reports strange random data error), please let
me know.

Thanks,
Qu
