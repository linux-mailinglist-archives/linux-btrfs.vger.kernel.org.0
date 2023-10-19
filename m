Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517857CFF0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346178AbjJSQGr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbjJSQGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 12:06:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6613B3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 09:06:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b9faf05f51so1255526666b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697731603; x=1698336403; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GAxqLkLulnMymSLsUeXBip1R0X962Uf1zax2/IweI4=;
        b=Cb/LAcA6Tj05FCBJ9PcxVmA815gWHITa/38TzDz/ehHiaecDtnFWjI/goAffLCvAwA
         cJkCmAMSEpwxYLTk7HlgsDQFnYLrSVNHl8co/JugZbj8PFMaNaHFQCHykYpX4hFXRm12
         XeICnwyb+pjB0ajHskYKn342JRfEnK/EUIQRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731603; x=1698336403;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GAxqLkLulnMymSLsUeXBip1R0X962Uf1zax2/IweI4=;
        b=aJQeNwJhokaQZctxW9OMFsZ5mmQbfERgPu+mbksRRtiNGYLPctveAu3xZh/YL1b08o
         AzDStUCrnHIxC3ZL+0GMKPVOQKkcvab/bsMF7koJxiyOcg4fo2p2sfUfMB426ZK2MFN7
         FvuKvuP6SVSbZFas7Cpu9I3XorirVBK7brx4QV60IscDv8HQ2BhaJVOjIF3BLnXk4711
         hOes5aV6x5u7k5APgdwp6OtQiidEMkx4SP63IIakA96ojBmW5JR++X4HoQeTqXAQpENF
         uJckd9Ic0iRa6qE44Ck6j9UKMKwPFynFp7FHq2e/JWkohgLT8FUtvQz7tSu07C6ymTt2
         STRg==
X-Gm-Message-State: AOJu0Ywyjh0KW/ERL7aaVbSuGa16wyk+UQfFf34Gj//4V6nDnBk2Oy5L
        m6bMgswr0PcDwqrjhEbxrt47anxU/Ell2E/iVVXrucpx
X-Google-Smtp-Source: AGHT+IGP4p4FZiqwGsDAnL8KPQpkmp5etXGLFh42k1XDHhMHAn8fS/n/RrNJxnmVjAkOiIaefvwdXQ==
X-Received: by 2002:a17:907:703:b0:9be:6cac:bad2 with SMTP id xb3-20020a170907070300b009be6cacbad2mr2602021ejb.45.1697731602927;
        Thu, 19 Oct 2023 09:06:42 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id oz4-20020a170906cd0400b009c751e41ebasm3065131ejb.141.2023.10.19.09.06.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:06:41 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9b9faf05f51so1255520466b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 09:06:41 -0700 (PDT)
X-Received: by 2002:a17:907:3603:b0:9c3:bb0e:d4c7 with SMTP id
 bk3-20020a170907360300b009c3bb0ed4c7mr1914249ejc.28.1697731601256; Thu, 19
 Oct 2023 09:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697555249.git.dsterba@suse.com> <20231019151204.GA13867@twin.jikos.cz>
In-Reply-To: <20231019151204.GA13867@twin.jikos.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 09:06:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiXFXaVrvN2pYUuzDX+xsuU6ogpU69v9yiPS7F+dFbOQ@mail.gmail.com>
Message-ID: <CAHk-=whiXFXaVrvN2pYUuzDX+xsuU6ogpU69v9yiPS7F+dFbOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fix for 6.6-rc7
To:     dave@jikos.cz, torvalds@linux-foundation.org,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 19 Oct 2023 at 08:12, David Sterba <dave@jikos.cz> wrote:
>
> I don't see this pull request merged after 2 days and I don't see any
> reply from you that there would be any problem.

Indeed, I don't see the original in my mailbox, so re-sending it was
most definitely the right thing to do.

> The mail is in lore archives
> https://lore.kernel.org/all/cover.1697555249.git.dsterba@suse.com/
> https://lore.kernel.org/linux-btrfs/cover.1697555249.git.dsterba@suse.com/

Usually it goes the other way, where I see emails in my mailbox, but
not in lore.

I do check my spambox daily too, but honestly, it's a "quick scan" not
some deeper thing. So might have gotten deleted if it didn't stand out
to me clearly enough.

> what's a bit suspicious is the "X-Spamd-Bar: +++++++++++++++" header in
> the raw message, this could explain it. Please let me know how to
> proceed, thanks.

This was the right way - re-send in a couple of days if you feel like
things aren't moving along as they should and normally do.

Obviously the first merge window week is different - at that point it
can take me a few days just to get to it - so then "two days" might be
more like "four or five days".

              Linus
