Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86E69D123
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 17:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjBTQMS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 11:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBTQMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 11:12:18 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D743B464
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 08:12:17 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-536aa45367eso28913077b3.13
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 08:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etDsOsklTFhdv20/ihPgdxxbpxkX/HMYSlW+AO+gqjs=;
        b=XIdlLW/Y3FKpBmW+MFh3PHZIVL4yzPdjvRL9q2jc+yShLVyzDRmAOkn90kRulptK7R
         Q/LMd6BRMP5wS8Gb2PMwRlXVTct2KTv78c+ZhhRnNdX7BIEU7n7ff1XZkBN/asygJ9MM
         oIQ5o5zHAuZDT3JTGm3xEfF48A5/l4lm13pM4BGh4YnixHVCs50ghm68Nw0ZEa6hEl96
         pOL/FkRyPQX/b+WLIle67ZK/gYPrQKMAdnijBSH5338W/GZSFFeRMfBK2ji82FzHigtZ
         hVHjeG5mA4bgjcdSueWC31CveOW1iYm3FKJMSif4vTW2sZWDwNADKg3FnZcJMXpu1Q4z
         PM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etDsOsklTFhdv20/ihPgdxxbpxkX/HMYSlW+AO+gqjs=;
        b=YyhoXYlgIfGWlYStzqhFFzRK9029Nln8lU9jlnNaH+FPHRQdfFQowWn7xI/j8XWOux
         1qIQY/H+PVN8H/I2Wzc7CkldfL3dUmsXndQKRqcELYZz1/M1w2L659zE49iyQ5+23zqD
         McVoaz9HoGX9DuEWfux8n0/NFCWo7b9M0pD9SKbEV/r5xfORLpGreRJ8KAUTZ87MJueu
         aaDMU7h20byYcR4dXH915Kjgj+0V9TuLrk66mBeTlng5WQvMz2WTXrnJ4z1wKgARe2/f
         jp8AsKUib1glKOVUDAL5YbQiRmySJXFi0zC8MwnzavMkysLijcrsmHIeqn+dgUDaDHXn
         0K2g==
X-Gm-Message-State: AO0yUKWbwY6QaccZE8asjM3YGAVkBWQYu2IezQS2diVd+O6S+2T2i6ia
        mI0e5ECOg48XxlCoT1QtTpTMLihW14wfejnVDkM=
X-Google-Smtp-Source: AK7set+Fwzn4lgWOyJ8bkJc3qySoYxX2UG1kpU63Obp77hehW17hLM7ag1h3lhX20281Re7HPtYwCqCTR7aWdEj67kc=
X-Received: by 2002:a0d:e7c1:0:b0:52e:ffc1:9e11 with SMTP id
 q184-20020a0de7c1000000b0052effc19e11mr2020316ywe.468.1676909536593; Mon, 20
 Feb 2023 08:12:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:6796:b0:47c:d87d:437c with HTTP; Mon, 20 Feb 2023
 08:12:16 -0800 (PST)
Reply-To: fiona.hill.2023@outlook.com
From:   Fiona Hill <lorijrobinson589@gmail.com>
Date:   Mon, 20 Feb 2023 08:12:16 -0800
Message-ID: <CAKXTXJzgv9Fpkjdereby7g2dLM6TbrgDLpOAscMa+LuRXvEvbw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5016]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fiona.hill.2023[at]outlook.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lorijrobinson589[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lorijrobinson589[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hello did you see my message i send to you?
