Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8F4CE7A3
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 00:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiCEX0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 18:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiCEX0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 18:26:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33FB6D4C8
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 15:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646522720;
        bh=lQJ9Xgnq+HSlzoWXPzZEdj70TqD5k0E0aXLzWVEzVII=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=H10aP71fwdXUeA45v92qTuwJO7TfiGWAFE53tqvAbGzAmfYgIYUH6bBH8dSBJhIhf
         CNiEJOBBYuOzGWIxKxc5hEffMq6JiElYB5N7UKpq4MueXl+EE60eHk4doHr1GFrqHC
         G02thkD63qvydKID/sTkcUP2+QDOo93uwF8IVcLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mo6v3-1nwdPQ1d0d-00pdrK; Sun, 06
 Mar 2022 00:25:20 +0100
Message-ID: <13dce6f1-80ec-d31e-4985-f39e33e2d502@gmx.com>
Date:   Sun, 6 Mar 2022 07:25:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: status page status - dedupe
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c1R2tOMZ8EB+wD5dZRH2GPBo+LQMtJh/EspcyKV9Cip+p/ulyvq
 fbmOnbYF1eF3JYLsY8y8VV90RFZdcbCAbx6BFTgrIHKZBHM1zhB6Y/UlLvztyPuYloEY9Ii
 SrxIruiuvf6IUCViY9Dt3yKlc+p0HA4XnCV/VthQ1N206LXR9lcM8YkxulO+m7vd6CneElY
 4nT/5AmkwFle97QhZ2esQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OnJqLEDJkTY=:zc8nHOMgl0e1RWmhwLgbJQ
 neK/56PjHPHFRjlJiZoTotsfVgWI61NnnYzseBeDwrgYjueX9q6nABt4+emewIzLDU2rrzL5U
 Zuc+iSG5RZyAX+vxzXz8oxufpdiJq2SLetJFhSAE1VB4L1dUquz2PThJtprJfpxPCJ5cbLAfB
 MB1357favcRJa7WaC28m04cXZVp878kLTsl6qahaPVmrTzjEBVjxrkjOC22VXqvUNsfAm5a5x
 IlFEllIIyzVzCP47N9qvPV+cwSu7op6S1Z/qIbkL6hnKqy7dv9Jx8SJXrMf4hHPudIA6GxhFH
 fJmamlgqxogL96C0KyBQyD9lLj34cR8R5mBn97I9Z3M3iSCg7BHvOgCTQGFp0JWHtD6Mbn3UJ
 MtEGzAsfZhBDayInnkM7Hf0HO8Ahgep27V1G1aTNE98zCOqXDA+DheFvPtqazyiZNqCv/otZa
 Ryos8ReGMJToRX7p/yGJ0C7pxQ9xvYhs3ZWWWkVLP41Qx9z9Lax0JfSXxnvmgVYJSVdb9NrWv
 DLx+JwXzrHHouXmHITOOJIhYzjlF+MPW/l1USGhLPYgnfG+vs8tPxEqTCnDz4v7Eph82093k6
 rjKexD0pSncXnWKQY95VJwmWTRDGQa9koCud14lwPgc9xeUlnmg6umJH7EZ3Wmyg+lTI6BPwf
 38CkJnlMej0nSnZrkjFWiP2PZYEE0jVrZtpg9JFcnfk3aNzDV7PHL1ZrjBwzC6d/ZlVDmtjJk
 5CNgedFZmqGW0Cv7dzs7FiyvEZGuliy75Wdw1DIYIUvhesyXOSdbvYKtzBLsnk9ZHeZca95aX
 li5Q7PQr624y87M9oNA7FatUH9nnstAJ5fUbOx1hmB49HKjwnOn7eWCdJAjlW0U/Ih/UGvRxN
 6IWWH+dcZdNL/2OQNmipscu0BSGQtahhrcRJ0fdsvzziV59RfIWJP/egpysJogiouSwVoTxgz
 5u+DkMS1yjPPX4nZMJlQKsFywQ8Or6dLHhLJx6YqZu8GUe5URBZlX4mAaM67F32nfqwEvNgTP
 t6U6CEr+ua+XweOWPHboUmysXJYti3qfbjTJmPuRu/Oh4oMtnuw09cTPFSGQk3KxEC9E+fdNI
 6s3wPyKO3fGnIQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/6 03:21, Christoph Anton Mitterer wrote:
> Hey.
>
> I just wondered about the status of the wiki status page?! ;-)
>
> E.g. it says seeding would be stable, while right now there's an
> ongoing thread on this list about it being broken again.

I'm over-reacting on that thread.

It's only in misc-next, not really affecting anyone.

>
>
> In especially, what's the status of out-of-band deduplication (i.e. run
> manually by some program like duperemove or jdupes)?
> Is it safe to be used?

Pretty safe AFAIK.

Thanks,
Qu

>
>
> My understanding was, that for out-of-band dedupe, the kernel performs
> a full byte-by-byte comparison before actually deduplicating, right?
>
> So it shouldn't matter so much which tool is used in the end and
> whether that's stable or not?
>
>
> Thanks,
> Chris.
