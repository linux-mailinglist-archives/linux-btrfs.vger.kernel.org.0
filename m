Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F1A589872
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 09:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbiHDHfp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Aug 2022 03:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239147AbiHDHfo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Aug 2022 03:35:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CCC2AF;
        Thu,  4 Aug 2022 00:35:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w29so14306000qtv.9;
        Thu, 04 Aug 2022 00:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kUU7ouVdRjlQZyoaWLn5OqlJHHixLW8OP9GlADTrqXY=;
        b=kmnPb+eTWaLetlrPOJOKDnRRJuO5waio55DmgqYVsav1cnix3d70kbPLMnVf+vBwp2
         oGK392ZIXOiIYR2th/+uyZHay4LjknD+NnJNHFBwkJVGIwN3+s/AqiBBhptuqHxCykan
         yHDKswdXHeuncwvnPMU7ENCvWVg/1amhTlBbybPWaCq2Mixfhcf/ca759Cs/JCZV3pIR
         m1nsFA577NN6/70hrhMl12WaAKFHEsB3FNPHLfai7r66IGA7WjlkSeJdtxWfe55OsEIJ
         qmbIXJ7ITOds2bZD+hGuX8PQNywI0BscZc0KVtRqwMf2uihTM8MkcDMSMj8IhYrzJmzI
         NLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kUU7ouVdRjlQZyoaWLn5OqlJHHixLW8OP9GlADTrqXY=;
        b=XwxIFJuFY5C3xeZMfUzY3gDAWfHCzQEQz5Y5St1njl5ueZ2txjMWlXEPM0vvJerpQK
         TPXiBOA0Nl9RImR1OY3O6Pvr1vmun/hpKkWkx0Ru2H0PLw5TptKfzB2nbxg3u1MJkuMD
         VwFK/1IEfhVxH8LA55TJH2mGw/N6SUXIdRR08ASTqnsdVW9lfWc8+UFaOSXMYtJiNYkv
         r4Xh+1Mf5kcMy6pDmrn/fEx6TI3nctSQdJcAZ5AAsnOB7X448NBglgsrwUijts9XfPqf
         kFJ/XKC5sWgOkVxP2Rd5z+k7ONfY2EEFzxtuiiFGm+lubuXk5eQdVcnGgcCJf+QxjmCi
         OIWg==
X-Gm-Message-State: ACgBeo0L7fvv/cCj1YuNU0I0iFNMGVJ5/A9WTKAjUKZks9q3T51QgBfm
        IfGlz6T4oqHj1MBaeU6ECM57Y1jrcey7JDEZi/Q=
X-Google-Smtp-Source: AA6agR7EuOtSctvB6c/cp8ufRr3H36twkKfFtPCr16T4HlTsyREBtg2dRw9kNpRz8f54IvQfieh9hSB3WwaDxehkbV8=
X-Received: by 2002:ac8:5e14:0:b0:31f:4280:8d93 with SMTP id
 h20-20020ac85e14000000b0031f42808d93mr424929qtx.36.1659598542111; Thu, 04 Aug
 2022 00:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN+BcaGO0+0bJszDPvA=5JF_bOPfXC=OLzMzsXY2M8hyQ@mail.gmail.com>
 <20220726164250.GE13489@twin.jikos.cz> <CABXGCsMNF_SKns-av1kAWtR5Yd7u6sjwsFT9er8tSebfuLG8VQ@mail.gmail.com>
 <1d1afda7-2b4b-4984-adbe-51339ebbdd18@www.fastmail.com>
In-Reply-To: <1d1afda7-2b4b-4984-adbe-51339ebbdd18@www.fastmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 4 Aug 2022 12:35:31 +0500
Message-ID: <CABXGCsO5+L2fX-wT=-UYFgzO9JuB7RNKDzv-wg5XrCt=yCuK1w@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
To:     Chris Murphy <lists@colorremedies.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 4, 2022 at 1:01 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> This will be making it into Fedora debug kernels, which have lockdep enabled on them, starting with 5.20 series, which are now building in koji.
> https://gitlab.com/cki-project/kernel-ark/-/merge_requests/1921

I saw this change, but it would be good if users of all other
distributions will be happy too.

-- 
Best Regards,
Mike Gavrilov.
