Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA20870A7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 06:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfHIEZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 00:25:52 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:56127 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfHIEZw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 00:25:52 -0400
Received: by mail-wm1-f42.google.com with SMTP id f72so4292734wmf.5
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Aug 2019 21:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AU9+SJRrIjalwISmLEA36IprN4nnVpX+LzpFEpKCB7c=;
        b=IZEUAZ8qeurqwATyZSEpwb+4LJFkoHFg6AJ5aO6jvxplrjfm5URR4qJIZ8SWw+ai29
         IumfNjUF0JiCJijfZhc1ZucEM6o6bVY+y1LTIwP8bGSXqceUclw91m9pTrQVaX4CLL4L
         9YB8JZU5BPmhnQoFc5/PfrVlJ5zG/jD9lzopCVipicdAZDZDBBN078RsdVGYH21kH5D7
         PBSfKcqlUiBBuCDc+5b77pEvZkwMRHWztjbLWCrj+AEeybuLYYLFlumsDYevJ6Rxz5fB
         aWdNWe7e+qftgTfibtJU9v4QU+4nW8l72CUwiPzGnvDaroGGcxddXWKzvP676CVcRZ2X
         muqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AU9+SJRrIjalwISmLEA36IprN4nnVpX+LzpFEpKCB7c=;
        b=lujQM9tmPDr0yjmTfX5UBczRGUci3EecU1wavuO5p+5ZtMBqYFT8whhLVk9tForct6
         EYZ2IC/fuc/GSzxhyWP7eGgzY1gsdb/Xg9HNmAzFVP+XJZr7Mt4IkjDZwvW315Cm+NbI
         v4uAyoD8H0RkDSfZemdbsQmzdmnJF+HpC8m2sJRXuiG1R+XYSFt6fGYWL2gpeJgG0mZ9
         qc+E1x4wr7BffXrLIJUgF/OMaJ8maqbpS/kl9ghzlNOwbtc99QZeOqAjY59Wpwdro/IJ
         C7iR3Gj/xauSXH5AkOmtT+OlVPZDadb4vbndf8fSFv68iFkA2midH5I3uEdkHiwJgYQ7
         f2XQ==
X-Gm-Message-State: APjAAAWiZZszrJD4oG2PfFbv4LK3PZud3BLUY4aLnOnwDq+2xOmoD736
        dgTj7ieKb36EFZElXSFOiL09+DBEIImC17S/UlWKVQ==
X-Google-Smtp-Source: APXvYqzYh/D0ncUHLk4WNBnC2oLgRbA7xCrhLmZyOfQ69EgygOjxwJxys2cQS+/KpHbEHbamCdB2bibmKCefACNEAq4=
X-Received: by 2002:a7b:c447:: with SMTP id l7mr7653273wmi.89.1565324749441;
 Thu, 08 Aug 2019 21:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190809012424.11420-1-wqu@suse.com> <20190809012424.11420-3-wqu@suse.com>
 <CAKzB54SN1FmGhGHQOfT2fvn=ESQn4vOwbPpPM7p8eJRkNmvf7w@mail.gmail.com>
In-Reply-To: <CAKzB54SN1FmGhGHQOfT2fvn=ESQn4vOwbPpPM7p8eJRkNmvf7w@mail.gmail.com>
From:   Alex Shashkov <oleks.sha74@gmail.com>
Date:   Thu, 8 Aug 2019 23:25:43 -0500
Message-ID: <CAKzB54QYNFjgfPUM8KqAHGPwSWPVczbhZidKpCpL7baJO8hzAA@mail.gmail.com>
Subject: Deletion on BTRFS - how does it work
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm trying to understand how deletion works on BTRFS. Let's say
directory containing files and other directories gets deleted. What is
essentially happening during this action, what strucutres get updated,
what artifacts remain after the deletion, is it possible to find them
and recover deleted objects, if yes, then how? Thanks in advance!
-- 
Alex Shashkov
