Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D276D58C2
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 08:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjDDG05 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 02:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjDDG0v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 02:26:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2DC1BE6
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 23:26:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ew6so126121390edb.7
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Apr 2023 23:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680589609;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYD9V4pde285MtBRGuFNN/Gd+daAbaaMaLJcbeGr6n8=;
        b=qI8VAdHjAmpLlSFbB4H2WaeWPrkrz7z1z8vKuY7txWXCBOJSCj7RHwo1PCQK/KaIhD
         0ZJNCa+HHU/Ya+Jhq/QstAaKo4ymVxL2jv/ktkGKfsAFx0ahmTZOm2gfoyDLHq+rMQYS
         0B37LUIJQG4R/yPyOhY/yud4guTV2gK/+VArfDzcsYGhkuWnGVlSP/q/ck9XQFqX0Gea
         aVhEaEmps8A8xCHE7maMUcv+Mhu3P0m+Ww1nzUiY83PvvGAIIPiB25blne0dX82MmRqE
         NIuayXvJbRyTfLMvsd6WSL81RDWpsWQkIl1UIM/tv3uJ5RtdkkaQSBAANECdhoHr2StX
         HXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680589609;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYD9V4pde285MtBRGuFNN/Gd+daAbaaMaLJcbeGr6n8=;
        b=ks0uR6mpQfx6unnjBCC1ZFTnWbTFkvxJ+lANa7xMcdE9KpK00AGACsKaTTWPsMCQUd
         yMsIlBNHDcFMvjVmc/4J3a2AiLsnVpKrMH/KwDqpB4c83AFxYtz69fukR9fD3Wucggp1
         ZyRiuT9qRDmJF27ZNYjkKY8YjTRVhNtjp41eLqLAdA+jH5iXcRE+o4O4SM85r/3uYgLM
         euduX//4gwPY66RWHnKBgtd/h7TbvhNhH0qx+YLJoNcg/ogSyfvcwDIsGXG2LuNYvM2C
         y8v3KjydFjFYLZepeNOTmbI4TvlgcIk7iJLoKTQjEqQe0ksW9OLSy9aqu+Tk12JubDM5
         bXEA==
X-Gm-Message-State: AAQBX9e+qKbU++st3jrJQ60qL8g5RvSBN5oH5rYfPzqrGw0llamsQHTx
        4qCeICLbjx/qSNzhfaGIy8m//SJnSJ7gqEfgnaA=
X-Google-Smtp-Source: AKy350ZDLhV18k/rYwc6HWPBFrplOFZA1FCCfxEouWIc0deXosRUohwbO4TYaPfIy2/q71utf96BasRg84+u/XNu+tA=
X-Received: by 2002:a50:9b03:0:b0:4fb:dc5e:6501 with SMTP id
 o3-20020a509b03000000b004fbdc5e6501mr811857edi.1.1680589608738; Mon, 03 Apr
 2023 23:26:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:90c3:b0:65:74f0:7ac8 with HTTP; Mon, 3 Apr 2023
 23:26:48 -0700 (PDT)
Reply-To: mr.alabbashadi@gmail.com
From:   MR ABBAS HADI <mrsm.schaeffler@gmail.com>
Date:   Mon, 3 Apr 2023 23:26:48 -0700
Message-ID: <CAEdRngn+-+kGPRn0ZzVuwVzAvCGT-bCUJv6xQP+zCx2_nKezWQ@mail.gmail.com>
Subject: WITH ALL DUE RESPECT,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Good Day,

I am Mr. Abbas Hadi, the manager with BOA i contact you for a
deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr. Abbas
