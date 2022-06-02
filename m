Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408ED53BAC0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiFBO2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiFBO2Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 10:28:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F5E14043C
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:28:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v19so6504473edd.4
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t59EIQ0hyVcxtLD6N5RG+b7iFkyE99qPAacM+Sfb8F0=;
        b=YPtjsM8/hzy7YR+dfqSQN0nnmD43JwpZkNWfynTgmFG43HUPCxoBJnPuQ99yo0G2/H
         SupVV9dBYKMvQihhfP/Gb4n4uri8rKIYX/L9gghAYfpNP8Zt8La0jLsm3xOOlQTyJMRH
         0un61c5hqsdoCzH77Oq9Cuk7q2kbqVT/Y1spsSDWa2vsQ7ZX8WVr5qeNGrFZK4wtzh69
         Mn7LufOrLEls6IHTfuZ5uGrV4lQArLylGv4uzc+Cn6w+QjqZ9XD2U/FgwJcsYlDwWTS7
         zG8Nx/5UVXh8f4jbwb3xcV3qLl/OAg6/KljuAMq3ePqXRWiCd1MnXdUhb7+N8SU02Duz
         FaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t59EIQ0hyVcxtLD6N5RG+b7iFkyE99qPAacM+Sfb8F0=;
        b=K1FB0Ei+LHLPCCBCjwAaanObrG+mtZAUl9g0pJLSrmkt3kjWhqO4ubOPyIsGGJXNGs
         7J1kFXOiwp/m1A9KhJsmrXgoFbhg2E+dMX6i4CaMHRhVKAiya1I79RqiRZUXwi+ATRkL
         stBixg2YBNs0gUFOAZ8HctmqmIChvNnGiRq5DYKoVJ9KzqZopUdk63qKBdE3+968J3/h
         fpl/oDOISWgYEqNc8Iz21mC0NdaXrYC1yxh1OWZv1b6IfuX6CzEBi5AThcRzOY9TNOi+
         3+6SHR9kgBoj3U+j3B8VQ4b6XRcKbM5NAAegQ6lB0RzjAvW2rpXJeeB9RLUpSWBVAaHP
         3x1A==
X-Gm-Message-State: AOAM531UgvYBYESkCbE99Bd2aoyjWaZxV7OC4bZMlz/wAhBgkWE304ww
        yhGMwecS9MPtYsRgz6y8kNMOnRMiRa5OB2HWVKL6jDAaDAY=
X-Google-Smtp-Source: ABdhPJzkBm068Me7rGcR8A9VlCGVbeW2mUwguigWQmUaoN5uhQFqH/zTY10qUpAEt00p4KBR/gscIf/ltGKF/MA6UQY=
X-Received: by 2002:aa7:c852:0:b0:42d:70d8:2864 with SMTP id
 g18-20020aa7c852000000b0042d70d82864mr5748171edt.379.1654180090661; Thu, 02
 Jun 2022 07:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220601225643.GJ22722@merlins.org> <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
 <20220601231008.GK22722@merlins.org> <CAEzrpqen1AXAYBq0M0LVzB8AVXMhAD_ve1Yj_+e=kPyCfdUiow@mail.gmail.com>
 <20220602000637.GL22722@merlins.org> <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
 <20220602015526.GM22722@merlins.org> <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
 <20220602021617.GP22722@merlins.org> <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
 <20220602142112.GQ22722@merlins.org>
In-Reply-To: <20220602142112.GQ22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 2 Jun 2022 10:27:59 -0400
Message-ID: <CAEzrpqdJHDte6jc7-ykD-wnuFe8_xB-Y4e97C-o5B-G-1Nnksw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 2, 2022 at 10:21 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Jun 02, 2022 at 10:07:27AM -0400, Josef Bacik wrote:
> > > g chunk 15323969355776Inserting chunk 15325043097600Inserting chunk 1=
5326116839424Inserting chunk 15327190581248Inserting chunk 15328264323072In=
serting chunk 15329338064896Inserting chunk 15332559290368Inserting chunk 1=
5333633032192Inserting chunk 15334706774016Inserting chunk 15355107868672In=
serting chunk 15356181610496Inserting chunk 15357255352320Inserting chunk 1=
5358329094144Inserting chunk 15359402835968Inserting chunk 15360476577792In=
serting chunk 15361550319616Inserting chunk 15362624061440Inserting chunk 1=
5363697803264Inserting chunk 15364771545088Inserting chunk 15365845286912In=
serting chunk 15366919028736Inserting chunk 15395910057984Inserting chunk 1=
5396983799808Inserting chunk 15400205025280Inserting chunk 15401278767104In=
serting chunk 15402352508928Inserting chunk 15405573734400Inserting chunk 1=
5408794959872Inserting chunk 15409868701696Inserting chunk 15410942443520In=
serting chunk 15412016185344Inserting chunk 15413089927168Inserting chunk 1=
5414163668992Inserting chunk 15415237410816Inserting chunk 15416311152640In=
serting chunk 15417384894464Inserting chunk 15418458636288Inserting chunk 1=
5419532378112Inserting chunk 15420606119936Inserting chunk 15421679861760In=
serting chunk 15422753603584Inserting chunk 15423827345408Inserting chunk 1=
5424901087232Inserting chunk 15425974829056Inserting chunk 15427048570880In=
serting chunk 15428122312704Inserting chunk 15429196054528Inserting chunk 1=
5430269796352Inserting chunk 15431343538176Inserting chunk 15432417280000In=
serting chunk 15433491021824Inserting chunk 15434564763648Inserting chunk 1=
5435638505472Inserting chunk 15436712247296Inserting chunk 15437785989120In=
serting chunk 15438859730944Inserting chunk 15439933472768Inserting chunk 1=
5441007214592Inserting chunk 15442080956416Inserting chunk 15443154698240In=
serting chunk 15444228440064Inserting chunk 15445302181888Inserting chunk 1=
5446375923712Inserting chunk 15447449665536Inserting chunk 15448523407360In=
serting chunk 15449597149184Inserting chunk 15450670891008Inserting chunk 1=
5451744632832Inserting chunk 15452818374656Inserting chunk 15453892116480In=
serting chunk 15454965858304Inserting chunk 15456039600128Inserting chunk 1=
5457113341952Inserting chunk 15458187083776Inserting chunk 15459260825600In=
serting chunk 15460334567424Inserting chunk 15461408309248Inserting chunk 1=
5462482051072Inserting chunk 15463555792896Inserting chunk 15464629534720In=
serting chunk 15465703276544Inserting chunk 15466777018368Inserting chunk 1=
5467850760192Inserting chunk 15468924502016Inserting chunk 15469998243840In=
serting chunk 15471071985664Inserting chunk 15472145727488Inserting chunk 1=
5473219469312Inserting chunk 15474293211136Inserting chunk 15475366952960In=
serting
> >
> > Woo we're in the transaction commit now boys, try again please.  Thanks=
,
>
> Sure.
>
> Note that you're missing some newlines in the output:
>

Ooops, helps if I use the new flag I added.  Thanks,

Josef
