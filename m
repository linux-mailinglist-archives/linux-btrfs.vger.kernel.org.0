Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696C548F322
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jan 2022 00:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiANXk0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jan 2022 18:40:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:57159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbiANXkZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jan 2022 18:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642203621;
        bh=ffn6hklokD/CuTSAEx2NWwD84J4ccGS2qoS80Qks21o=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=D1wK06T5O4QCcKO8Uwy6omr44I0sJa262YUhnnbvZ61767fLUjdwl2xnw6chT3ORq
         mVEBkLbxGnwM8nWHO3F5INhllWmPvGfxVcxTb3HMHppXXMNUzpWC8NJnhgYLQAQ2Zj
         ykE1Ow7MqpfzBvhfj7NS6jkYzd7pmJ5YQt+KcDtk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGyxN-1n3tbj0eVH-00E3BG; Sat, 15
 Jan 2022 00:40:21 +0100
Message-ID: <550b61f3-2e3e-3c5a-17fa-0be8b63269bf@gmx.com>
Date:   Sat, 15 Jan 2022 07:40:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/5] btrfs-progs: fsck-tests: add test case for
 init-csum-tree
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220114005123.19426-1-wqu@suse.com>
 <20220114005123.19426-6-wqu@suse.com> <20220114164059.GD14046@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220114164059.GD14046@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t445gIoyOaFfAraidWh/02UPywaKG83f7W54RrLS2GGcdxqGGRv
 7IxqvGY0cK7185QVEtTIO8VbFNrIx1LdGzJALw1b4ZMHxP81qZ5LRPnHIaPtc4mxmLiQyKP
 cO8EUpmn+5L1+FvTLMF5rHud83ghDVQj7zASJ0XSehwUXx7QlipPuRLkxUG8jvJHwiYzg6S
 okW8FD/0chfM40b/xsRTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6ONqkBfK14=:gmkLBv/XVqVwq5l2DWEM2p
 sCYUOLuVmDNm9iN5xPS9zImRSPestjKG7o61K9b92t5oLlu0NCyouQCq1WZ7EdySQ/l6PX/MC
 lpwJDPBGkXKKPkvmc4C9gT/jphNCJaKC8FRWmQQfMVS5MeDw5u6X++Cd9djvJgSZJRKEjlv/Y
 MhSQ9jaxY8w7pSaz/Xf6/O3oDdeXxHxDDxKOG8l7lZhqOwdGkdR6uqoqoZbv7B6RnD3BXTBPF
 aCZaELadV9UNdfT1K5B0telx466cSVgk7at0s59M/Xlx4ITcH1qRobYHXwcbXy+3BbU8NNBIh
 v1CXAl3LAbHxjJ1yHL/4PvvElrOpSu44req2onoC/3REx+3odWVV8IMdf00g/1Mv7A3l7rASf
 cWpC20EJ2Hw7ToqB6pFmsCi8RLDWl/6aEzbNrctCl/pJtlL6SSKUu935Rt+vPy6QSIdappIks
 yvxfJfBIhWqvNAIazha3uW53BaGlWoO4Rt1tY8OgX/2Uhs69QGcWalIA8Yoe4jktytfzj6zHq
 wIZxcyCHvyd/Mv6fz9AGQfb3ZXEkTcCslLk/y3x710VSUzhLZMEP37svrPaDKOBKHeOK+XvkU
 fr5j24TQQ9HWykeP50lO/GtE9gH1sHA5fJMSc9tbyEdaTK913Kvb/QZwBp52S8syaMfipUvo2
 Z3hXXjxrm2rglw+CwnSxZRY2qIZj/PdxB21DmpHxiwaK+nR4x30XCFZ2hNQTVi1sGypLjmu81
 giO0BSzsVFRF40O91h0xZJZeSSzTlvQgvfSqPCUAIBPSgPg1lArgBXft2Sub1MhML96NmQkyn
 9Z9y0pqpZD7OVwMymEMQ0MBiLWPFb3lkiHqz9az3ruGw/wT367O+VQejNIHvzTtog/fQJHIQc
 cmzwwVgNLFAgNpXCw6lvJ4EPVA6598PUiWYUbxrKtH6QdsiMmcqM8qhVZEd4tRHnLdKO7k+8O
 Ig7eddImG9M/dq/fqxPBDTK+4Mig2r8DqUByP1PYS6vqHevNk9Jqws2/9G6dN124HQi/EclBh
 kgO0U3E+ispIABA8muPCYNw0D8W+qnrNy2bQsejdP2XDjlly7dLN3Kx0VQfY1ZshdeYPXfE0s
 6ObmYsJy2HJ2wc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/15 00:40, David Sterba wrote:
> On Fri, Jan 14, 2022 at 08:51:23AM +0800, Qu Wenruo wrote:
>> +run_check $SUDO_HELPER "$TOP/btrfs" check --force \
>> +	--init-csum-tree "$TEST_DEV"
>> +
>> +# No error should be found
>> +run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
>> +btrfs ins dump-tree "$TEST_DEV" > /tmp/dump
>
> Is this some leftover from debugging?

Oh, sorry.

Mind to remove it when merging?

Thanks,
Qu
>
>> +
>> +# --init-csum-tree with --init-extent-tree should not fail
>> +#run_check $SUDO_HELPER "$TOP/btrfs" check --force \
>> +#	--init-csum-tree --init-extent-tree "$TEST_DEV"
>> +
>> +# No error should be found
