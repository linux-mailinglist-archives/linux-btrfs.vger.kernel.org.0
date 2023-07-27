Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4A765F5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjG0W0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 18:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjG0W0N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 18:26:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B3AF0
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690496770; x=1691101570; i=quwenruo.btrfs@gmx.com;
 bh=W5+V1P7/3ncOCIdCrzNhpfa8UmergkXQCRulTXFgGOg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YZPcz5+RrPB/ksUKK3U+DAL0kXGW0Pby7Ok4fpZ2nDaFHTQbc/bD5xvZ7hvNJ10rmX1NqDn
 l1cvMrhnsCh3o03EORa8cqXjddwNV2Lcds3WwmWK7EmJ+TR3dw5NdgEUSXggGjgjT85dxjg8v
 Mo84VmvB8e98eZZMeQGbj6LmjbgSkSa3d/TMTu2w0QhhCUi7Ib7fb4nmVZ26Qds2dXpMzJoX6
 XDRSO6AkOPM3GvtxHG3i/aSu+kqpcqHf7IuZ16J6l3RA5KHEevb0SJOhkqY+vttvdRr4SdB41
 mi5MNz/VBeOF5XQGiQyIxSUvob5xJyBsLqFpZpWoD3tkCxeO3biA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3KPq-1pgMWB0LAY-010KBj; Fri, 28
 Jul 2023 00:26:09 +0200
Message-ID: <135e0fdc-2f16-83ab-ee27-2dfd8465797f@gmx.com>
Date:   Fri, 28 Jul 2023 06:26:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] btrfs: do not commit transaction canceling a
 suspended replace
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690437675.git.wqu@suse.com>
 <18f1e6d4afa0db4aad56569bbab15b220f03236f.1690437675.git.wqu@suse.com>
 <20230727120955.GB17922@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230727120955.GB17922@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VezvtOuhQS2IErNWIwUrmjFJP7xROV0zaogfDPkMkrn8n3uuaSx
 qBRNEsubh9+ER7fyvCu/lDx0BIN2/678+D3ftKSgvXGc26C/BgnSXqvURRGfwvWE4RUjFJI
 orUE48sJaLkPi0kbiKnlGebinHLM+eHw4v94bsoDGal1hYo6T0gdx3gm3ry/kqYx/SARJFm
 w1mIqNbCAAU2cmcXfJrew==
UI-OutboundReport: notjunk:1;M01:P0:N8ej1wqL6xY=;NgHYA8+tg22llOtx1ijb8mkamz9
 +mJya5KBbXHMjKoZCS1vCaTz9HHsi/Qv9ee5ZZ2oa0C6piaNmmV64f6tl8dzxS229UOHvXg74
 776o1ZZMq/BCmUV6iB5SwOwWSfOkBA4Ti4+fndvtwjdqQWrQB5QfHxribQV8P2RUPKcQwzytk
 DqZdh6mgrBg3NGqomaPwlUwa85fbqL/kPrhKMp/sVN7Y8rH5QNL2g5UofoOobeylGslRjnRjN
 8rUh5DzpovW7gIRnB28vmXVAev1BwngPB7vnSN1HMRYTWe/zfyhq4sywVuja3e8Dj4ZG1lgqr
 wElBnMUhg4q90sUVCWVEZzjkOhjfLg+A7LzBXUiCbm2clL9wV5xaCSg7F+4j8TwIqGffjnaxp
 AKrFot0sooqBj9AkaM+C0LdnVwlqr6b6FZAcxeV7eMGV681jdHJpGPQggpIfGmu3yHbEuZnNO
 eWVAyoeai1TCkFOCL0UjcL92NlA4C9Tjh1oUK/xiISChT+BCgMpMHmvwF5KPX26DR31eLDReE
 KaBktnglzQS9GZOXavZWlULByiuGa9C1QDSTgdhelr76yCF2Hig3rMZ9KbfFlRUAerq33sXsP
 j5rCjsYH0T6t0ftY3gBTQyPjU72HlIg5f6vpivzyOvTpPVNROGPOEtChiIR54M+NFCfd81cuj
 nyX12g2ophj4BxwsKr4/eHyoXlmal8JvKjccRDbEwFy4xyEvIY4ZnshBAvrr3qKAFre1EN6/R
 LrQyXdNcNq/KiVbuyOb33ZhXSnHx0qwj4vksATdO8LOSQL4+b08h0VWoGQg1jxhi7jZzLXq5F
 CyB0KW9R4Ky2I5e3G8CGn0Y8EsdJxnWVKMEW7CYliuHydUR33zQ2XRyM/UNcmluEIpMcsKRcC
 8vky9qlkQUoZShJwdEimcaouYsyiKV8yxbbGJHZN+DiUoUu3Cv9OthQnslsJbWaqEInoXrZSZ
 mSZID4J4iel0YzS/HqftD2Cq4E0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/27 20:09, David Sterba wrote:
> On Thu, Jul 27, 2023 at 02:07:54PM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is a very rare corner case that, if the filesystem falls into a
>> deadly ENOSPC trap (metadata is so full that committing a transaction
>> would trigger transaction abort and falls RO), and the user needs to
>> cancel a suspended dev-replace, it would fail.
>>
>> This is because the dev-replace canceling itself would commit the
>> current transaction, and falls RO first.
>>
>> [CAUSE]
>> There are two involved situations:
>>
>> - Cancel a running dev-replace
>>    We just call btrfs_scrub_cancel(), it doesn't commit transaction
>>    anyway.
>>
>> - Cancel a suspended dev-replace
>>    We only need to cleanup the various in-memory replace structure, whi=
ch
>>    is no difference than the previous situation.
>
> There's dev_replace->item_needs_writeback =3D 1, and somewhere in
> transaction commit it's synced to disk.
>
> btrfs_commit_transaction
>    commit_cowonly_roots
>      btrfs_run_dev_replace
>        item_needs_writeback is checked
>
> so it's not just cleaning the memory structures, it also stores the
> state on disk. A delayed commit will have to write it again, which means
> that the problem is only postponed.

That may be exactly what the end users wants.

Delaying the commit so that they can add the extra device (with patch 1)
to escape the deadly ENOSPC trap.

Thanks,
Qu
