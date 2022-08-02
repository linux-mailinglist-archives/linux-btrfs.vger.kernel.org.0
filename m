Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68E5881B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 20:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiHBSKH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 14:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiHBSKG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 14:10:06 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B40613F8B
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 11:10:05 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g1so11196948qki.7
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Aug 2022 11:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:from:to:cc;
        bh=LSDAWvBJ2TcDQ5DimpCC89MAHJkG4as9CPVgEmfzHIY=;
        b=KErpGRXffnEV3i7vpdp/xNYLIIgJJ2o2w1N3zuk5nN/oqIz8gIHfeFCB4f/VlO77Iq
         tAknEhsdI5wWB9tN5j2KRbwZztYmsFvOy2FKgMiWYxQXIqBM1a14P/W/ogFMhCLM8yR3
         PlFiF0DYFjSTJ+cOGvwZpoZyUFkYy9DZQv2prP8SU6m773XT94zJUoxNySIQ5sKWSmPP
         rjC2SBsLnzCck2d5wgKKDq++i33E+N+9NNr9jM6hPvISUDw/68OMXZeAuMUsMQ6wG2wP
         4st5SlezGy6LFg8aLnAn2j6owcBHzztIE2XeGRmYvtECaDn0NpG1KfQijSjxMUESAcKk
         pJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=LSDAWvBJ2TcDQ5DimpCC89MAHJkG4as9CPVgEmfzHIY=;
        b=D4Zm4qxlsB+WKNQtMX0W5+goW7utqeImXEWeypJXrshlywZrQniHRQIRIjXxgZSVCW
         C7kGOPdraxrKhN3Hz9mdz9Fm75qwQ8KubuMGz7uxhshBl9CUhxzr7X7U7eFHhQgmOibo
         pzcFzNnw4GwjRgZeqtf2envHfGSVcLBmcXqHmXKuDfG7arhHHuc0qBrABwWCoHz77aJf
         D5KE8xBJnmqDWCGqt6d2Di8re966W1JH3ezrwpcp5Jf3OtroXjSoLDYNzZb4Q99Q732A
         zWkvXKFLlwCupZ3nLoXuWOaRvT8Myv3WhHqDUfc9WGDoH5niJkS9DHW/BZ0ng3BPnnD3
         zyJA==
X-Gm-Message-State: ACgBeo3nA1fjaqIa5/i2g98BsuF5k6wTko7CoaW+0GghJEOOvbPWYUXt
        OsMDDzF50qQFOtIERGLYvLVjseuV1a/t/Ef7XMs=
X-Google-Smtp-Source: AA6agR7AuNwAGQBbaJfsocf0WFaeC3H6dUjU5ytCaDaRO+NZMPH739Qe45bLc6JzqR5Z6XJ1bIqq2Qr+9dWcVfKAgjg=
X-Received: by 2002:a05:620a:a98:b0:6b8:e5e3:2f34 with SMTP id
 v24-20020a05620a0a9800b006b8e5e32f34mr353623qkg.233.1659463804710; Tue, 02
 Aug 2022 11:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <27a36e2b4cf30de8f7a04e718ba47bb9e98ddb85.1658419807.git.josef@toxicpanda.com>
 <20220802171744.GU13489@twin.jikos.cz>
In-Reply-To: <20220802171744.GU13489@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 2 Aug 2022 19:09:28 +0100
Message-ID: <CAL3q7H4i891513XvuGoDgWtpg_GggLsCkoqthadRfYg4+op1MA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix infinite loop with dio faulting
To:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 2, 2022 at 7:00 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Jul 21, 2022 at 12:10:14PM -0400, Josef Bacik wrote:
> > Filipe removed the check for the case where we are constantly trying to
> > fault in the buffer from user space for DIO reads.  He left it for
> > writes, but for reads you can end up in this infinite loop trying to
> > fault in a page that won't fault in.  This is the patch I applied ontop
> > of his patch, without this I was able to get generic/475 to get stuck
> > infinite looping.
> >
> > This patch is currently staged so we can probably just fold this into
> > his actual patch.
>
> Folded to the patch, thanks.

Please don't, revert instead the original patch.
See my previous reply to the patch.

Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
