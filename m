Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D522BF92A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfIZS15 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 14:27:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45144 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfIZS15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 14:27:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so2595010qkb.12
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v2M8YwQgf//RIpWRAmquP9FidbLrgWDnSZVvfDvmeL4=;
        b=Sm5+LQye1JTabr8cNpW4Pq9KjELSgc3zrHihXPG5ZmAY2NsDC6nY9v0FLRET/JMXGF
         0ncamXNNvhkRlJpSorLzA+uCuPtA5zLTrjpT/91iUL16U0GGN2tmb3B61kV5l96R49af
         8IxlFkVbiI7+zDvSH3ur4lCd6fobHzwYfr/6X4W+Fo+j/hpaMnzf0QIDOvmDdzABzqxy
         kR8B6E7g8loKwLFt1RU5EzJ5/UoNTWeC+zOFivgvSZQ50n56Gs06XZ0miulCQD+4AOTO
         b0jGsWsdDiTEP2lrhmOoI++jsxzKGp2POizsSRua4OX2HkLoi78U+DQXVeHVVIBwsdMI
         9kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v2M8YwQgf//RIpWRAmquP9FidbLrgWDnSZVvfDvmeL4=;
        b=YROLRkGrWIOXX6ZzTAKxzg10pzwAZGUrWqo/LuLdaI2AjDenrf6nh2ol0DUph/Wy1K
         pQ+K53whUhO6Ay0iJI4xXow/eraMP+0jHAbIGXJFArzYIgyhVTaGap9pluwuRBkQ7zKW
         Omp/9rHyxI8wl9XGjo4ljHHz3jw1Mu7ZUxUHAWZmXGRyyTpSe6dJJQWfuadLAaTUt069
         dp03atOAUX21umfLr9cBqPC5nXIAok5PEuqpMWAoQP+9jWeqbZ2MFbAjN+gGbkPGpdLZ
         CQlHzBNW0bYNrSQv7q2cClyI/BNYalEwg3gm7g6E6eXi0BdvccnjwZ5j7g0rJB8nvuu0
         oxxg==
X-Gm-Message-State: APjAAAUNhxpmZpTyBPmHMbx4kwP9LZ1EMKQhoeEZnOZ3zSBzEOzOIQkt
        W+jqbSIMDyCIXfPRNXACONsQQeEu3wJh6g==
X-Google-Smtp-Source: APXvYqx3eaA1ivbdPcggfTTmdytNEkXWj4bAAmc4RopQGF2Hbr4frV5iSPMMI4xruHL/flmb0qJcBw==
X-Received: by 2002:a37:a9c1:: with SMTP id s184mr209283qke.360.1569522476619;
        Thu, 26 Sep 2019 11:27:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c9a9])
        by smtp.gmail.com with ESMTPSA id w45sm616190qtb.47.2019.09.26.11.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 11:27:55 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:27:54 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Simplify btrfs_file_llseek
Message-ID: <20190926182753.57h4mdyvr3hp2u4u@macbook-pro-91.dhcp.thefacebook.com>
References: <20190926113953.19569-1-nborisov@suse.com>
 <20190926113953.19569-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926113953.19569-3-nborisov@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 02:39:52PM +0300, Nikolay Borisov wrote:
> Handle SEEK_END/SEEK_CUR in a single 'default' case by directly
> returning from generic_file_llsee. This makes the 'out' label redundant.
> Finally return directly the vale from vfs_setpos. No semantic changesl.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
