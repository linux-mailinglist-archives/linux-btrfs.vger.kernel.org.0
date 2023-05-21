Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3505D70B1B3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 00:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjEUWbN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 May 2023 18:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjEUWbL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 May 2023 18:31:11 -0400
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DE21A5
        for <linux-btrfs@vger.kernel.org>; Sun, 21 May 2023 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fsf.org;
        s=mail-fsf-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:References;
         bh=exZjY+79LM6x/+qgYpHYpRTuj/ScViVpDKC/rf4w4TE=; b=HIFL7zV6LNbNeseH8Scr84h9N
        O8BYD64/0TgZf5JF7wPA0Je9z4Rf/HmV/0iTlgT0trsWO4R3ZYFBdWC4wY6gOuXJ0767lmKfqD8EE
        xN9mjK2M5yEwIlUG9o+rH6vN7ST6xOZr/vqf+4AtuykvrNb4TLRnVt9ZEJclS6uh5GjkvK1bHJB4b
        GIgW5qEPa2UgH0Gv5TfF3PtmVE3oDPlmiF5ckL3f5dObJ6+hEOpI0Ckkww/yE9W3Qvn3TN6/X9WMP
        DQ6Y3ji/GlNOjLhbzfX/pCd5/hD6HVU5WtO/CXY0HF2OSNMqSUMS+6N/brcLzFotsSkFaqOIYJPF2
        sWc1HfyNw==;
References: <87mt5y4uyj.fsf@fsf.org>
 <c5a798e3-4b58-a074-01a4-def09f136d38@gmail.com> <87cz67nhv6.fsf@fsf.org>
 <5133a57c-09f8-4cd0-633c-4ea921fe2a41@gmail.com> <87a5ymct4o.fsf@fsf.org>
User-agent: mu4e 1.9.0; emacs 29.0.50
From:   Ian Kelling <iank@fsf.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs receive: ERROR: clone: did not find source subvol (user
 error, not a bug)
Date:   Sun, 21 May 2023 18:26:41 -0400
In-reply-to: <87a5ymct4o.fsf@fsf.org>
Message-ID: <87ilclpbaj.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Scratch that, I had the error again, and there was no simultaneous
snapshots. Again, I needed to wipe the relevant snapshots to get work
done, but next time I'm going to try to save them off for further debugging.

Ian Kelling <iank@fsf.org> writes:

> Upon further investigation, I'm pretty sure there was an error on my
> end, nothing wrong with btrfs. A cronjob was creating a snapshot on the
> wrong host with a name that lead me to think it was from a different
> host. Thank you everyone for the help.

