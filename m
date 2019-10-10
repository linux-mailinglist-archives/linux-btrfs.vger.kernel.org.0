Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9D6D2F57
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 19:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfJJRNF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 13:13:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33564 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfJJRNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 13:13:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so9827249qtd.0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Pz7bEaw57AuKDXahsQpnRGNhcjlq6gmo4mgdLnUW3s=;
        b=kAz7muBOFMScu7RhRIwg7PkGaUAyeLxcGNWNSzJch1fVZWt7t6juv/YH+XExZrur76
         t7WZrm5X5a77wsFwB6ED+vYDk66RdWYr+6W6ushAi27XmTd2HH0qHD0a+E+vXrDB+7Xg
         Y217uZ1xwiycB+YeIXamNaQVSowrJuONbVD6lC2MbNjVyjLr8YArtPazKjORZ5UYt7yg
         Wy8jiniLxYlCxH8gzSWS7yI8rcCsEC7T8QTzJ9uoiit7kW3UxINXaz/CHCs7LIm5/ZzP
         BpdIMP7VKjxpgZ+t6AFMbSOa/Qcaatrqf3LDPGUuLJeq3WafC7Fe0JCUmQPzx9Eo2VLI
         5i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Pz7bEaw57AuKDXahsQpnRGNhcjlq6gmo4mgdLnUW3s=;
        b=M8s80uNmv2DK6/+mFCyKf/dSvExd5B41eGWs2214Wr3c+WhZy3mJpS8yhLO25WrmuL
         sIb9LdydY+2H24bECSBqb5VLPyrMtJr2bXv8mEpWOltGsqMLOhbURYFGFYJEzJMQDwzk
         WbgejDZv1AfFjjxD4uewIC+ifyGRWJmPGGQ41UM2eI6KUbcMI1q945BYYXOTLUNCF32q
         GQw3pipxO50q9Kmi1X+rZCafnVtz4t8xGb/W2orK+92Ei/AO3KBvD8Aii7f+qLtctp9i
         yTHs47awG1SuMHKZfN0qmHdyGUt9Zwon2HMg98WhaxII7qtvBbKdQzRMx/TtAvUdqTQu
         oTTQ==
X-Gm-Message-State: APjAAAXKjblkO1CK2nTUlkdR+VOnuNUQL7HXwhq+klO8exPNPAuxhkzU
        lQw81rSBsygBhdDRAM6yJWPeft3MvELZYg==
X-Google-Smtp-Source: APXvYqx0zX2CFhRxniWwKLzgJyTUvwrnK3i3EIqyAV0+k+dk5xs12G1rUTgukLBId2lUEr5+rxv94w==
X-Received: by 2002:ac8:1c34:: with SMTP id a49mr12020546qtk.140.1570727584073;
        Thu, 10 Oct 2019 10:13:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id r1sm2915823qti.4.2019.10.10.10.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:13:03 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:13:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 16/19] btrfs: keep track of discard reuse stats
Message-ID: <20191010171301.ynbmcebqis4dfxx6@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <60e557d71cb58574edbc2c429534fbfefd55df48.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60e557d71cb58574edbc2c429534fbfefd55df48.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:47PM -0400, Dennis Zhou wrote:
> Keep track of how much we are discarding and how often we are reusing
> with async discard.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
