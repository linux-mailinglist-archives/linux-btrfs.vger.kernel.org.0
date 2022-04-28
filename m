Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53C35129D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 05:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiD1DL3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiD1DL1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 23:11:27 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A3A5DA40
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 20:08:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id z12so1185162ilp.8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 20:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhwYG85AmJOzBzvax6rv+g7O/oZt/WA/B6Ia/5Q3HZE=;
        b=CCg6wU1NsjLnyVQrgkUvojBPkBatnYFA//2vuHYHw1hQRRXIHKQPR5QPRjChe/nWk1
         6JX6rcfGNeADzPf06P7lKBFdEYRFmNoFsGZ9GCDu7OxqH23zMQg2k7nc4wodfWVaXFBa
         hXV0ZrWDyd2g67YQOuqh++yuk9DM3j/w54SuZ7cnEWDfFPHjw0vNW7tY3z+jJPVNDYkp
         KYQMf2tY3vowe54E+tEXGsdidDXicSEkxCimXmkwUgZ1n6IS7FBrW10fzSyQ2mp+yyIr
         kh6slDiNJqW+fdZM/01LYyuMr4Ft7DZOitos8h+CmbuWKUZ0RzyOAj/xSdCTzULLQ9RM
         FtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhwYG85AmJOzBzvax6rv+g7O/oZt/WA/B6Ia/5Q3HZE=;
        b=o6FJdEamoIKYjXU4UKm/beMiqXi8Shsuy5sca+Vr5gBAuQqGh7/es96MUOTuFJJbnK
         nIHOuVsmdqeXKMUhLfhRMrwlH/EQclsnTE+3TG9gkKRjLjQMeFUrmuSZWDGf2tw4yfqr
         WkH9UPqkldeizj+O6SGNNJb1SsWoJKuLzB45up4ogH1148YUHEMD7/1OQPwsGL+W8fUw
         ltXpnj0yf4b/VCIYdVKJOC1H53rZeWNmJn7vP1YFv6WcUJhYzgp/POopEwbJSwp4cbqe
         Yrkh2J7YDnzqj32a4xQ4S3uiBKN+jaiInS7fLL4nIjZr6B/dgv0/kWqlOWf2ILxJYqAK
         B37Q==
X-Gm-Message-State: AOAM533Tk/Wbtq6w4syRGlGhGd55aRA7hZEAklcQfkIPClvrYGxlCdrH
        frM89oGBLUnJImiu87gVrSJAPLxsMYf2CmOYvQPudKcRBrc=
X-Google-Smtp-Source: ABdhPJyOGpAiixEtbg6ujqW+H7107AisglreOTNRfTio/t7yQD3fcCCGxITMlYuO7llckgXnzrLie26qaIy3j3d9k1U=
X-Received: by 2002:a92:d2ca:0:b0:2ca:ca3a:de89 with SMTP id
 w10-20020a92d2ca000000b002caca3ade89mr12726953ilg.127.1651115293713; Wed, 27
 Apr 2022 20:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqc7D5A6xZ7ztbWg4mztu+t9XUPSPt_gEgAbCCzVzhnHbA@mail.gmail.com>
 <20220427210246.GV12542@merlins.org> <CAEzrpqezdFDLGjLvzznWrxCg11DptboeWCc7p_Wwz-=q5H+00w@mail.gmail.com>
 <20220427212023.GW12542@merlins.org> <CAEzrpqcvrA+qJspsusyk2fOOp5WovjWQEGX5sZA=Pr8pQRb9wA@mail.gmail.com>
 <20220427225942.GX12542@merlins.org> <CAEzrpqfN9QQqyRAoy=YOpcaCWnKCzpDcTxAtYNUGE=7A2vRTTQ@mail.gmail.com>
 <CAEzrpqfXFxunfC3KnVnWH4yqPTf=nkEPPg3dL=OPCRYhUvjPww@mail.gmail.com>
 <20220428001822.GZ12542@merlins.org> <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
 <20220428030002.GB12542@merlins.org>
In-Reply-To: <20220428030002.GB12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 27 Apr 2022 23:08:02 -0400
Message-ID: <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 27, 2022 at 11:00 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 27, 2022 at 08:44:01PM -0400, Josef Bacik wrote:
> > Ok it should work now.  Thanks,
>
> Mmmh, it got worse, unfortunately
>

Well not worse, just failed earlier because that's where the new code
is.  I think I just made a simple mistake, but I added some print'fs
just in case.  Thanks,

Josef
