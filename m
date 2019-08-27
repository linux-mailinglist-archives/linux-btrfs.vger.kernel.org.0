Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799079F617
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 00:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfH0WZG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 18:25:06 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46411 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0WZG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 18:25:06 -0400
Received: by mail-wr1-f44.google.com with SMTP id z1so355859wru.13
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjh/WFISj1DgrtPbp8sbT/AaEFThQIM0cScWWSm1z10=;
        b=MqQSgu27LTJaV2W0RZ8aj1x6rqXgEE2xlvPsh6cuBpK5Ph/bBuoc7QyYYN8ryQcD3v
         YA+SBgj2ZlTHM158YF+dPADxlaka5GpyPRqnU6vZAc5/s1oU6ak7Itg+2VakAjKMuvek
         iKxVlW5BIBeI1xaFWHpNdLkcLouNrJ8fkH9BwEfi/5r4PN7yEeTDZNvcOuQ4cgC43oxC
         0LJ6UTzqFxW4GHgNIbpc57Qdkxn9dVf18MYTc1H79azhdFUHgZkavI+dz7oqnyC9y4Gi
         aw4mrfpy8Wels01JovH4ihNRQ5UubXyYW2nV1Sg8JDgyuFEJk8JRsM+dLtd22dEPaN/S
         3LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjh/WFISj1DgrtPbp8sbT/AaEFThQIM0cScWWSm1z10=;
        b=LTIav3adFg4mEXlZbWhxJEMcpNsmDOpnI0Ypdrtq/Gt7S68jfqHKdkc8Ba4Br+VnSX
         RiF2z8uP40hQ9w6s4rWP2YbDNiaAVgZNaCAZNIDA1ClQ9vjT/COLJXw0xpL5NHOVQ/30
         7y7Rhj9WGKeJwqx5KCshhOcLskzvD6OWxmk2e29o0KudS3p6KQMOMZGCLZJTQFMmoLtO
         pbwaJi4j+SAMD3nfVAhU/0mPI1ACwUuUDRKy9yVlzCFQrQeYYjuXpWLTeeOKAB2BijkK
         1JnzW1Ei5x6C+8H+MPIhxU7bb91aIYdiooXnNVvyBP+a+RshuMskJfmoRPZGJia4AOXd
         zVbw==
X-Gm-Message-State: APjAAAWB7oZ1TCvoF/1heKYauBH5tUqYP0DszrZEscqk5sSbmEI1Fvrb
        4wGqbHrZpBfj2VXwnFwZutlmVv68A92VufiPnoLaVsqHzVc=
X-Google-Smtp-Source: APXvYqwcRQb8E8Nq/mVDvKN7SKGfUfRIrynQKnBsZTAtcw1QtfMfQf32htgXPjB1hL/IX/In3Qi9L9w/GaBeYxbxSK0=
X-Received: by 2002:a5d:494d:: with SMTP id r13mr409506wrs.82.1566944704899;
 Tue, 27 Aug 2019 15:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
In-Reply-To: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 27 Aug 2019 16:24:53 -0600
Message-ID: <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com>
Subject: Re: No files in snapshot
To:     Thomas Schneider <74cmonty@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 3:33 AM Thomas Schneider <74cmonty@gmail.com> wrote:
>
> However, I run into an issue and need to restore various files.
>
> I thought that I could simply take the files from a snapshot created before.
> However, the files required don't exist in any snapshot!
>
> Therefore I have created a new snapshot manually to verify if the files
> will be included, but there's nothing.

Snapshots are not recursive on Btrfs. The snapshot will not extend
into nested subvolumes. Check to see if you are snapshotting the
proper subvolume.

# btrfs sub list -to /var/lib
# btrfs sub list -to /var/

In some sense these are redundant, I'm not sure if your /var/lib is a
subvolume or not. Also please include the exact snapshot command
you're making.

-- 
Chris Murphy
