Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F2D7D8E67
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 08:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJ0GD7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 02:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjJ0GD6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 02:03:58 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC0C1AD;
        Thu, 26 Oct 2023 23:03:56 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d332f23e4so11394786d6.0;
        Thu, 26 Oct 2023 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698386635; x=1698991435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd1ycto4mVFRP65nCnRxY/cb/URbObkN/cMQE6EEz18=;
        b=JAzHAIUflXfxLy+RAkhAf906cS2ggAvs/mh+SLmrV61H3KdnPVUR7h4H071/8u47+a
         AThArUpY0jTVQxs5pW5/FR11vb9s4ae/ABE5ciqwzfyrCvygNlVmlIYMyTk0UOHHKRm8
         gPYiBHiZr02+gfbOCjz1ErNsonzadhQfupq/TbC5/TCCin02wnjZlRSCF6aDKCYBYMYo
         BrTLVj4nQMMsjUPBQ0Xy9eqhQV9V0vq7IRmcu0fu7J4HRMsUMkClVNkX0RKPFHxn4THk
         gSvaidaTtr5XB8mQF1DckTfzTR+1l1dsJVr1Yk4oXP0XgtPRnezdI28ne3e81IZNnzac
         aOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698386635; x=1698991435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd1ycto4mVFRP65nCnRxY/cb/URbObkN/cMQE6EEz18=;
        b=LRirJbq4y0K12ScpUqEDiQL44HYrKmsN7wQ1t7wL5rh0tBjNH/kn5Lus2pQ6es0uMv
         EQDQgelLHWsxgXDanWffXEe9JGVXK9QJZ7eIayp9SELLTSOOTx1z2GiPt8XU6F6lP/Kh
         VkD6oRXvNRlSMOXZOqIWqpxkZlJLdl4wb6QXD0sTXZMpDKhxLXONuqLbWSFWObxEgY8F
         PfUTT8LaMYv5AAnN6+RjH8MCCeIXYLeTtXtzumZZ5pmzYhELQewhmuDo1CbmA7bJzhXu
         EEU8akspPkkmTMZBeOC75o2syIUPTlLXxb6YNqW+4CG/GOQ1iXCsBSrtoHt2byBQIA9u
         UF2A==
X-Gm-Message-State: AOJu0Yy2S+I8pq7JL22qGZn+0oRw1sMYdPUkaocDQptaFLgWBJjaMcPj
        5uX8xINXPVSJKJdnuYxBB/jkgFsIsjqp7ZOTz0c=
X-Google-Smtp-Source: AGHT+IGkLjCDaYZl19jGFLkoUVkIXXVLEBuAIWxYvUsJHEporf8udSq+g7aG9Z9owgySDFa5DH3xyY5kJ+px1ISRe+0=
X-Received: by 2002:a05:6214:ca9:b0:66d:544d:8e68 with SMTP id
 s9-20020a0562140ca900b0066d544d8e68mr2485608qvs.3.1698386635059; Thu, 26 Oct
 2023 23:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231026155224.129326-1-amir73il@gmail.com> <ZTtOz8mr1ENl0i9q@infradead.org>
In-Reply-To: <ZTtOz8mr1ENl0i9q@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Oct 2023 09:03:43 +0300
Message-ID: <CAOQ4uxjbXhXZmCLTJcXopQikYZg+XxSDa0Of90MBRgRbW5Bhxg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 27, 2023 at 8:46=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> As per the discussion in the last round:
>
> Hard-NAKed-by: Christoph Hellwig <hch@lst.de>
>
> We need to solve the whole btrfs subvolume st_dev thing out properly
> and not leak these details in fanotify.
>

With all due respect, your NACK is uncalled for.

Did you look at the patches?
Did you actually study what they do?
Please point out a single line of code that leaks details to fanotify
as you claim.

The "details" that fanotify reports and has reported since circa v5.1
are the same details available to any unprivileged user via calls
to statfs(2) and name_to_handle_at(2).

The v2 patches do not change anything in that regard.
This is an internal fanotify detail (whether we allow setting a
watch on an inode inside a sub-volume), which does not expose
any new details to usersapce. It has nothing to do with your
campaign to fix the btrfs non-uniform st_dev/f_fsid issue.

Thanks,
Amir.
