Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27153BA77
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 16:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiFBOHo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 10:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiFBOHm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 10:07:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E15A24707D
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 07:07:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f21so10168506ejh.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tRGRMtf78t2Jhui/IqPL4lTfkZFS7MLHPE/zJRMgk4s=;
        b=4Hj3TqAodcaa6uKr5weVPDUMfRhE/VUAibcAVwKGvqYglpQs1l58sX5i+Ef8/FNJUy
         XEeWoxBk6Xp8hdDY0V7IGY7CVor+G0hzA1Dn1sB0OWeeg3Yo8dMuS0oeGGQ5G6cH8/S0
         ZV39My2rna8NVlIM4Qxyjn4ZthRBTj8QlAWgJV1I3RMTk/i9GL49TJqCh4gyX1foP6Xm
         yKZQkxKCFV+MX5aBozb2ZAzzk3zadlt2IEgwqvcBr7C/BhEaU7Wo9ke/E8Q9CRKWX6DM
         WSMdrjV4sQCrerabjBtH1i7d2yLIe2HWeA7VYGTuiBhSQWsf9MSNjDo71633tAggQUok
         bfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tRGRMtf78t2Jhui/IqPL4lTfkZFS7MLHPE/zJRMgk4s=;
        b=W0qKEUbUwYTjwf0T0CuhHqvf5q4sYrNL/PXJ6I6TiwrpVxlOayyRJMrU7Rn66w059J
         s25gIO8oQgHtBpjEQDuNMnTE0Gywm0efIi+cFxN/1u2yAP9eGWZuZc5VOXSd7dqugjXR
         BXjM9cti8heBS575jVSu/ee9mIhVZx2q3GekzfGp39xUGPZwUFO+05q04a7f9RPCp55c
         OKlox/Dq56RQjyQbz9d28Tvzvk3Ouxli5Tanf28mfaFB1ZEB5+W+kga4AEAA315qJinE
         8eSEOVt5vla4b+hYUvlAye8kXfS0ALPe/RO3TZ9RjY0ITyfGUrvCcgsxYx+pDDUcKFG+
         uWhg==
X-Gm-Message-State: AOAM533lUjffFqqgRWp6xiIrtK43QFfsa6dwl0LgWYil+xQbPDN3ehX2
        Es4OgFKZIzc5KH5om+xYTGQUly+gLwNOYMcydRf7M35nz0k=
X-Google-Smtp-Source: ABdhPJxvgoF/4f7xz7DAHCV/pspOO8L2WwmqSTQRp/pcpQ2dBMMBNEaaZVhjwGidqXSmz3E7YNYXPsi/i79kgdk1wY0=
X-Received: by 2002:a17:907:3ea1:b0:6fe:b735:a488 with SMTP id
 hs33-20020a1709073ea100b006feb735a488mr4457261ejc.574.1654178859382; Thu, 02
 Jun 2022 07:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220601223639.GI22722@merlins.org> <CAEzrpqdfz5FMFDiBbb1mrUTXqxNvJ2RkuqJCdE2VQ6op01k61g@mail.gmail.com>
 <20220601225643.GJ22722@merlins.org> <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
 <20220601231008.GK22722@merlins.org> <CAEzrpqen1AXAYBq0M0LVzB8AVXMhAD_ve1Yj_+e=kPyCfdUiow@mail.gmail.com>
 <20220602000637.GL22722@merlins.org> <CAEzrpqc_Z=aqbfNHL_r=8X1=-Kvdqrmdzrd04M-n=79s7Mi26A@mail.gmail.com>
 <20220602015526.GM22722@merlins.org> <CAEzrpqfMD1+c-datNzDWppr62NBz7vDHybeXqg55DVVDAiqAdQ@mail.gmail.com>
 <20220602021617.GP22722@merlins.org>
In-Reply-To: <20220602021617.GP22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 2 Jun 2022 10:07:27 -0400
Message-ID: <CAEzrpqfKbEvZh1td=UW6HGJ1x3htSVL1jo49KzcJPu+OSYt4jQ@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 10:16 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 10:03:29PM -0400, Josef Bacik wrote:
> > On Wed, Jun 1, 2022 at 9:55 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Wed, Jun 01, 2022 at 09:23:30PM -0400, Josef Bacik wrote:
> > > > Ah ok I'm not confused anymore, try that now.  Thanks,
> > >
> > > Better:
> > >
> >
> > Ah right, we don't actually use the normal free space cache.  Fixed
> > that up, thanks,
>
> ound missing chunk 14400551387136-14401625128960 type 0
> Found missing chunk 14401625128960-14402698870784 type 0
> Found missing chunk 14402698870784-14403772612608 type 0
> Found missing chunk 14403772612608-14404846354432 type 0
> Found missing chunk 14404846354432-14405920096256 type 0
> Found missing chunk 14405920096256-14406993838080 type 0
> ing chunk 11143322009600Inserting chunk 11144395751424Inserting chunk 111=
45469493248Inserting chunk 11146543235072Inserting chunk 11147616976896Inse=
rting chunk 11148690718720Inserting chunk 11149764460544Inserting chunk 111=
50838202368Inserting chunk 11151911944192Inserting chunk 11152985686016Inse=
rting chunk 11154059427840Inserting chunk 11155133169664Inserting chunk 111=
56206911488Inserting chunk 11157280653312Inserting chunk 11159428136960Inse=
rting chunk 11160501878784Inserting chunk 11161038749696Inserting chunk 111=
62112491520Inserting chunk 11163186233344Inserting chunk (...)
> g chunk 15323969355776Inserting chunk 15325043097600Inserting chunk 15326=
116839424Inserting chunk 15327190581248Inserting chunk 15328264323072Insert=
ing chunk 15329338064896Inserting chunk 15332559290368Inserting chunk 15333=
633032192Inserting chunk 15334706774016Inserting chunk 15355107868672Insert=
ing chunk 15356181610496Inserting chunk 15357255352320Inserting chunk 15358=
329094144Inserting chunk 15359402835968Inserting chunk 15360476577792Insert=
ing chunk 15361550319616Inserting chunk 15362624061440Inserting chunk 15363=
697803264Inserting chunk 15364771545088Inserting chunk 15365845286912Insert=
ing chunk 15366919028736Inserting chunk 15395910057984Inserting chunk 15396=
983799808Inserting chunk 15400205025280Inserting chunk 15401278767104Insert=
ing chunk 15402352508928Inserting chunk 15405573734400Inserting chunk 15408=
794959872Inserting chunk 15409868701696Inserting chunk 15410942443520Insert=
ing chunk 15412016185344Inserting chunk 15413089927168Inserting chunk 15414=
163668992Inserting chunk 15415237410816Inserting chunk 15416311152640Insert=
ing chunk 15417384894464Inserting chunk 15418458636288Inserting chunk 15419=
532378112Inserting chunk 15420606119936Inserting chunk 15421679861760Insert=
ing chunk 15422753603584Inserting chunk 15423827345408Inserting chunk 15424=
901087232Inserting chunk 15425974829056Inserting chunk 15427048570880Insert=
ing chunk 15428122312704Inserting chunk 15429196054528Inserting chunk 15430=
269796352Inserting chunk 15431343538176Inserting chunk 15432417280000Insert=
ing chunk 15433491021824Inserting chunk 15434564763648Inserting chunk 15435=
638505472Inserting chunk 15436712247296Inserting chunk 15437785989120Insert=
ing chunk 15438859730944Inserting chunk 15439933472768Inserting chunk 15441=
007214592Inserting chunk 15442080956416Inserting chunk 15443154698240Insert=
ing chunk 15444228440064Inserting chunk 15445302181888Inserting chunk 15446=
375923712Inserting chunk 15447449665536Inserting chunk 15448523407360Insert=
ing chunk 15449597149184Inserting chunk 15450670891008Inserting chunk 15451=
744632832Inserting chunk 15452818374656Inserting chunk 15453892116480Insert=
ing chunk 15454965858304Inserting chunk 15456039600128Inserting chunk 15457=
113341952Inserting chunk 15458187083776Inserting chunk 15459260825600Insert=
ing chunk 15460334567424Inserting chunk 15461408309248Inserting chunk 15462=
482051072Inserting chunk 15463555792896Inserting chunk 15464629534720Insert=
ing chunk 15465703276544Inserting chunk 15466777018368Inserting chunk 15467=
850760192Inserting chunk 15468924502016Inserting chunk 15469998243840Insert=
ing chunk 15471071985664Inserting chunk 15472145727488Inserting chunk 15473=
219469312Inserting chunk 15474293211136Inserting chunk 15475366952960Insert=
ing

Woo we're in the transaction commit now boys, try again please.  Thanks,

Josef
