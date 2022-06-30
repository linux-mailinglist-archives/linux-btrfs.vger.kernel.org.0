Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF49F561F92
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiF3Po0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiF3PoY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 11:44:24 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C18EB83
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 08:44:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id jh14so17379078plb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=oi5iv1Eco29TGWSBwnHFaIYlgioBoeM6uySqEn/MgudX3skVnQhMhIPLZqEA1veGk2
         979Y82bHoVtyYmIZMxwZDAiahko9VKumpX4dfIcUttCL7YtDxINBbvr1CRBTCD1HQpWu
         8ZwIIYj9zutE9dQ2jazzW3TTBtJrqOlgjg1LrqnPqslwPQr4OK4sk6sADXiaZ0yUhiUc
         NsekDzXStqna1XFlo78Y5USwupGmueRa3XDgXhHUQIIdMVvEV4U6k3pksA/ZEI/1ADDT
         9S6Nryo2m6l80EwUNfBH4BRifHgUCEb+L0s0klhfHQj6HpP/+e0R2N4g73dlOE0YplHD
         AvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=edeevZ54MxyNr2ONaDsC9jI+UtdZjrCL/LCuSFC70Ao=;
        b=oTAgqOdrF+cH9tSSrZ5N0ses+m1A7eZxIQ11RPnwT3un9JDYZwHHP0khDfWOJgUu52
         hzMb/jn27THmeEjj1/KepbUHJmjn7FNmJORRWEIM14sS/SqyQhX/wJdG3MuNdHmR2NTc
         gGvRo7oyv85S2s5xrAOhJRwIg3bawh33ca9jzdMzCyUfDg9jyWXZ2GXFxI8lwDX0upfe
         1bMAdntpkhmkxOcYshBDK0gLN1CRqnHjqbnSjiVCdIQ7YlQHmE8+ty332KrUI8Tm0KXf
         qyy4ucL9jwp3vfuUk4bi5Vec911zhJYRt5chWm50RO043p7q+ViFZt6pfydsFkQd1r+L
         yrOA==
X-Gm-Message-State: AJIora++1oAvorSiSER4/kNb2FJs0xuLVO9VSNLdtXhLD+MLuw0B9GNd
        PcLSNlgr7P2XIHvrre/ev+qyrUJgB+ANaEpk+Q==
X-Google-Smtp-Source: AGRyM1vpnTT1OWeTbvK/uRBSn0+8FIb+vveeWkkr8htW+vi0+QbcBnOg1Nwhw5dTFCLCbvcynExdxNQa3abPHDR3HPg=
X-Received: by 2002:a17:90b:3507:b0:1ee:53f4:59aa with SMTP id
 ls7-20020a17090b350700b001ee53f459aamr11065251pjb.27.1656603863063; Thu, 30
 Jun 2022 08:44:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:185:b0:16a:29ab:582f with HTTP; Thu, 30 Jun 2022
 08:44:22 -0700 (PDT)
Reply-To: mohammedsaeeda619@gmail.com
From:   Mohammed Saeed <mitash.m.patel2012@gmail.com>
Date:   Thu, 30 Jun 2022 08:44:22 -0700
Message-ID: <CANRWfSMJjPT86Fahtr_XkuyKs0zUW8Nd5u23apOxQYsnnBLO-g@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Salam alaikum,

I am the investment officer of UAE based investment company who are
ready to fund projects outside UAE, in the form of debt finance. We
grant loan to both Corporate and private entities at a low interest
rate of 2% ROI per annum. The terms are very flexible and
interesting.Kindly revert back if you have projects that needs funding
for further discussion and negotiation.

Thanks

investment officer
