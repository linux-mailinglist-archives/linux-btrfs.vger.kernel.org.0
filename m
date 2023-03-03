Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF98C6A9CBA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 18:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjCCRGO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 12:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCCRGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 12:06:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEA85CC12
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 09:05:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id da10so13044126edb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Mar 2023 09:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677863139;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaGR8JZOHt1+PZWECvLAlEp09E7L9G6iDAsr5ENQO5A=;
        b=RvMuROWbcC0tHkSNnDcUWNOO47hp6I06N4EQCt1HFSs30DTNgzU9pzhKJnMDlg5Vmv
         IejM2rVJ/gjUi06hKMFFO/Kt52zTuQAX3MCPs5V+wtp5wno+uCXEbatFqncwmIasg7Nt
         DfNwPl0PnaOJm8eOutLk5vCC9JhijaOxcsbPBEDCcELl0ZJBlUjiM+40w0I4SpNBKLna
         5lXiRxhIfJT8whz6LMpy4XguiY5qO68+ZzGs51JAEm37KPL6UWEU7nwon3cYrzhSCPhg
         rleb5LLjZj8Al1Ixq1kg8uDulEFbv4CbNifh7yeIpcDJtVpbyYjXqVVmgVb/s4mNtuuv
         s8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677863139;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaGR8JZOHt1+PZWECvLAlEp09E7L9G6iDAsr5ENQO5A=;
        b=r+Bf6qvnmPLs0lFYfq7EGpHLtRKpgsFiCaFtXUMAOo+aI/xPlDso/ZWUPbRnlL+z1e
         JyZbW752eLA8jxeflMp4Ddhcv+lqg14PTU+OD4dtNVAu3wIJljsrrpbq8sfHYeuHD+Io
         G4TIxg8I8lJ+zaU0Ykcu/NDX9Zqv0k4KtODEYo9IqFMIGDHQquH0dHMyeiB9RS6Ctqi+
         W47Elv42fZEp5ZYA4dHvnc/bS9PzJBpXZyee985E+zYQAwrpgIrEwGAiZmGETeHUCIma
         RtVgeUjZ/GQKLTndp9XNZkgQS7j0DAzfnVh433CQmDswNvtzLSBL07B0HHRV5rmF2vEM
         HKig==
X-Gm-Message-State: AO0yUKUrAYIBXG7maalmUIXVcvcMn/AK63kHd3Y20FjXI+6VrfueZPbe
        55DmI8Rjm3GKsbvqgJzTut0VO/cy39swDvz5L8I=
X-Google-Smtp-Source: AK7set+ccC3EwTldkcL1/BryFds1HXIPiXFrZliL+NwzhfI+Q5pMTHncTDhltQe5fyGFHCWQ8B6tq3N9F9RMo46th4Y=
X-Received: by 2002:a17:906:60c7:b0:907:3615:326c with SMTP id
 f7-20020a17090660c700b009073615326cmr1215665ejk.7.1677863139316; Fri, 03 Mar
 2023 09:05:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:3107:b0:64:9a2a:903b with HTTP; Fri, 3 Mar 2023
 09:05:38 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <sylviajones045@gmail.com>
Date:   Fri, 3 Mar 2023 09:05:38 -0800
Message-ID: <CAEsQPx40osiz3ORzs9oeAw9zQ96sQK3ryPz_6V-yzuE+H0ZC1g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52e listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9885]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sylviajones045[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sylviajones045[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Hi did you see my message i send to you?
