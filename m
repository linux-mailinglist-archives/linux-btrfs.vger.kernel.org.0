Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB3F2DE04
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2019 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfE2NXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 May 2019 09:23:19 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:33965 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2NXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 May 2019 09:23:19 -0400
Received: by mail-qt1-f182.google.com with SMTP id h1so2523295qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2019 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5aPbqyQyMSJnLbYKPVImnO+ptWE+VGRcIPmJIPcJTi4=;
        b=FA/jj7EQQHMV8jLA1glBtSJTzY8dnPavZH/BtsmmzOsW2Y4c+2PhtAEi3saQF/lb9I
         eps+Xu3zMRil0OyR0eoYbYsDWADNgDZnwo5xZ2OSehNuU2bq6p0V0xMHwyMbRV2FOoGc
         nXx8WwkFb0HnR8oiCjqWkT1czQ7MLPhw7PTDpVL25VQfgsymihDdkJzgA/PSJ04yw9+W
         vlPyqMnp0sv57VIt+8mKF+iXQc5SZLPgdF+ykeY64co5z0jmTlThJiio7c8kCKfhkL8/
         QxNX4BSG/0vQh7M3WnC5tcVd+694lwFB/9tuAm/bpPJVDY+J+i55s0HnpqlaOpdqfrlO
         oIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5aPbqyQyMSJnLbYKPVImnO+ptWE+VGRcIPmJIPcJTi4=;
        b=EAAYkksShhT6GfE6t5oHV0b3+fs9RizPqrQghr7GBk2qJXR0MfNGTIs+hROw47yEjt
         QOIbzDjsI9vd82TEHrx7XfagjD4aAYGYRXxvYdsAG8s3ukmLjgzxKyaSSBO8KngsS26P
         bTeOvnqKdhAcU8g8V/7O/vonaIleoAPr+CR4j24/Uz0hWU/AKEyZ91f8VhpcXfKufayG
         xtyFz/zRv9YTZMoIMYh7B6vJ5Lj+xZhzln1D4rpegCk3ipJrs/Q3YAD4NhGcprabHoHW
         Vjgr+jhaTmVfvh1pNAQozZQ4yxOC0Ez0ejRzK8grrSaqjJHy+87fw39Gm2DLVQgykqFu
         vrEg==
X-Gm-Message-State: APjAAAUxEHprIUWOxFHGIoK5M+L9fFpQ8w83lh5DJ5vqQ/vc76wZcVlB
        vNfIl9iZWkZKj+G9ey7XDtomSEanKDBDQWLblLWYkqKIn7AsRw==
X-Google-Smtp-Source: APXvYqyysvJCR0fCyR6WWZbdgNS7bsTcdneO4buZpj9QLAa3nE1E8lCxgd4JB7jsQh+sBllrvG9jKaIgF9BOJbD3BVQ=
X-Received: by 2002:ac8:1a8d:: with SMTP id x13mr9828738qtj.114.1559136196067;
 Wed, 29 May 2019 06:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAPxZtjG1DdHN9c6adtiyDahUJ85earQS5=9skgWopYg+m_7uUQ@mail.gmail.com>
In-Reply-To: <CAPxZtjG1DdHN9c6adtiyDahUJ85earQS5=9skgWopYg+m_7uUQ@mail.gmail.com>
From:   =?UTF-8?B?V8OoaSBDxY1uZ3J1w6w=?= <crvv.mail@gmail.com>
Date:   Wed, 29 May 2019 21:23:07 +0800
Message-ID: <CAPxZtjH-4XL8L6CikHS1i_RyvLhMQNbavmq0e-bbFXy3i+uRag@mail.gmail.com>
Subject: Re: kernel BUG at fs/btrfs/relocation.c:2595! on 5.1.4
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I upgraded the kernel to 5.1.5.
Got the same error with the command "btrfs device remove 4 ." again.
