Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8F67B1C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 12:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjAYLmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 06:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjAYLmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 06:42:15 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02861E076
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 03:42:10 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id p22so9695433qkm.0
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 03:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3Y/wTKWhzzOkdiRbXgW8Jx5JGSOv3u+BLUkT/iXFSE=;
        b=OPJtsM5OQRpGkH9OjxMuZb+XsgJ6KJrgCa+cGy40qRGx0fhdg9Wesfqs64ihrzDTDx
         Grlw8+heD3dziKRWyyPRQVLK0Aq7M7dLaMUBRRVBo/ytsDUa7H00t2G8ymHhnJya/vHS
         kIo6iVdlo+/horeLwHoquuk7tnsZtfUA5c14aIfT2nu57Q+s4fbPfKuGszH0x6UAcY7/
         SS99vHv+vWIJk/XiaDS1BKwTSGakNj+8ug31ojXsD5GOT8xVdEgssf+YY3itcw9aqsD4
         SwPbaybEdSDux+AJ1KNPeFYc4WOIXJ4bPsVqpX78m/YSvxtwxj2ccVVAuLmVnF8MocN5
         bdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3Y/wTKWhzzOkdiRbXgW8Jx5JGSOv3u+BLUkT/iXFSE=;
        b=yabN07W18hGVosbDU1/sbrPVQlGeF737nhRr5W/SJeznnl3qB+lHyhjYDcE5GlgPEF
         l0cmNY5nak0+C8iMVsPX3ZkWFSpU54Z0R1RlCANe5Pcn5X2+qXrMap+tbnrPes/Lzoj9
         rnJGWb/PAY5ErrZeGEMh4JZbYnI02OKUfHwTI4WAxPkk/D5y4TCkbtG0if0MNsiDEtyQ
         dUr0W7xdsDzImiAfqKo1ZAMgvXEnID6f7LKLPZkFn0uzjCiOYQoF2GjdVRzbUaVKXCq6
         hJm+d5TQKFaAtURYD2/EL/bR1EUf52JGffMMHHw3y9hvCS3lKGmWTGTwYJY/7/bJRMvb
         w4EA==
X-Gm-Message-State: AFqh2krfv5chasT/TTe/yfRFAmWdmQoqUN6UAjF9RsrarF6VKCv3D4/+
        U38v1mzf39xyF3ReLeF0pcLzjAwfcPIKGtvZMg0VEPNEUdk=
X-Google-Smtp-Source: AMrXdXudpBPFt0O39qXYHwCg9wbEwIR+thsWVGp1DTS7IZCnRJEIwBO3al3GBcKT+t7+VCf4tmN//2GXAW9+ajboXQ0=
X-Received: by 2002:a05:620a:268d:b0:706:c1a8:89ed with SMTP id
 c13-20020a05620a268d00b00706c1a889edmr1755763qkp.768.1674646583428; Wed, 25
 Jan 2023 03:36:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:aac:b0:533:386a:85c5 with HTTP; Wed, 25 Jan 2023
 03:36:22 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   Mr Abraham <mr.abraham2021@gmail.com>
Date:   Wed, 25 Jan 2023 12:36:22 +0100
Message-ID: <CAJ2UK+aG6RrwvU8i8Di33sAdm5xZe1iVowmd1_oza9Lo_spU5Q@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham.
