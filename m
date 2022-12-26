Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F4C656277
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 13:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiLZMP3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Dec 2022 07:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLZMP1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Dec 2022 07:15:27 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ABA6340;
        Mon, 26 Dec 2022 04:15:27 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id g8so5125057qkl.2;
        Mon, 26 Dec 2022 04:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z9d+Du5QUXSuYQWwD7dmsLyKR+Vfc18ibGUUnNESGS8=;
        b=DSFXLigQQ1LccRjWTRNQDCW7YoJpQJUfD54eexHDVJrWxjGzGTXHxDeFNF0DIfj4tk
         KkeTFfJOWLkT7BV5MgtoV6UTDXypTD8F3n1xW4D3F2RgXwHrUBmheaUUF8Fn8fPmVYC7
         +6k1yzcOtBSTCMT33/V4sAchitOsQtgsothMn6GDWWN/nKx8SnlJxsg1WHYSf/wYSCOf
         sN7UywRxfj2BFi+THvDYPM80yZJzxtZe5k7m5eFkrjti/GNuuKgARbre6byLQ+odfOxf
         3P7v2gfPfUWCUneH+Yo3F//ql3ok2GNqW6/1T6jTJOhBGLag5vjVxSO4whZDpM/X4woe
         wtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9d+Du5QUXSuYQWwD7dmsLyKR+Vfc18ibGUUnNESGS8=;
        b=KaXF2jiN8AnIJIyor5+nCBg2S833xtOEp/VByUB/w/letoXjX0kNJONIEuwO1imUl7
         rIlHnxvgZSIAwUzllRcgSazYLjBCzjWI9xR9DntpyDo9Ira1HF3Sy+M8OTvLOswqQOkv
         ubKPJQcfG0Fe0DOiJG3uNhFQw7VntBlkhbE1TUROZ8t3xrDW6X75V13IWm9S7JHfhorb
         PLehs6G0TQNSsytI2fsmiHvAwBDkoIr7w61I3us+5FrGp/SL3RYLY1H2iNL51fWUOdbT
         ot5K9c5bkpCsmTmw8aueWXR2tNcaOKXmEH1snwe0pE5ESd/HahPIenBmF9sjLX6qs+kT
         HHpg==
X-Gm-Message-State: AFqh2kqUz1eU8SK+kIIogdlEGetwpI3XPk2gSbEb+OaeV0PoWW/SISuZ
        DxJaptHQIQQ9ZjILYG7NUQ9vcqvik6QM+wqhdDA=
X-Google-Smtp-Source: AMrXdXsbEpwx3VFRbfv08ioESYM1S/UiVgY/Pkln9xHnJzuYKS4lludLvbVMGfLC4WcO70JTZBPGE5Fo4q8BuhxrCTc=
X-Received: by 2002:a37:6397:0:b0:6ff:b44d:4856 with SMTP id
 x145-20020a376397000000b006ffb44d4856mr881396qkb.205.1672056926060; Mon, 26
 Dec 2022 04:15:26 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <f68699c3-ec5e-d8e8-f101-6e9a7020ac81@gmx.com> <CABXGCsNrm3ddn3p_ECSRe+yQeoF3KojTFvy-CpXNzi9ADkbnvQ@mail.gmail.com>
 <18b5fa1e-7d1e-4560-c98b-d7ac5fc87c3a@gmx.com> <CABXGCsM5y6m=pLX7tyE-RB1yuHEgZh3fxDu5ESfTRxEnW+djZA@mail.gmail.com>
 <0036622d-53f7-eaba-f720-6dd9bdca28ad@gmx.com> <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
 <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com>
In-Reply-To: <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 26 Dec 2022 17:15:15 +0500
Message-ID: <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
Subject: Re: [6.2][regression] after commit 947a629988f191807d2d22ba63ae18259bb645c5
 btrfs volume periodical forced switch to readonly after a lot of disk writes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     wqu@suse.com, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Mon, Dec 26, 2022 at 5:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
> While at the caller, the structure is properly passed in.
>
> So there is something wrong between the endio function and the check.
>
> I have created the v2 version patch to debug, please apply without any
> previous debug patch.
>
> Meanwhile this really looks like a race, thus I'm not 100% sure if my
> debug patch would reduce the possibility to reproduce.
>
> Your bisect should be the determining evidence, for the worst case we
> can revert the offending patch.
>
> Thank you very much for all of the testing, it really helps a lot.
> Qu
>

Looks like v2 version patch is missed in last message

-- 
Best Regards,
Mike Gavrilov.
