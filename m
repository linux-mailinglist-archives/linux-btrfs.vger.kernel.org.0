Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC4BEC125
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2019 11:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfKAKMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Nov 2019 06:12:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:47402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726948AbfKAKMr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 Nov 2019 06:12:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69431B57A;
        Fri,  1 Nov 2019 10:12:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4367DA783; Fri,  1 Nov 2019 11:12:54 +0100 (CET)
Date:   Fri, 1 Nov 2019 11:12:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Antonio =?iso-8859-1?Q?P=E9rez?= <aperez@skarcha.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Subject: Re: [PATCH v1 04/18] btrfs-progs: add global verbose and quiet
 options and helper functions
Message-ID: <20191101101254.GH3001@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Antonio =?iso-8859-1?Q?P=E9rez?= <aperez@skarcha.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
References: <20191030084122.29745-1-anand.jain@oracle.com>
 <20191030084122.29745-5-anand.jain@oracle.com>
 <CAMhy=vK7HcCHs2JxQUQ5Fyz1CFuAp7erm_2v5ZYY4Ud+BRczZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhy=vK7HcCHs2JxQUQ5Fyz1CFuAp7erm_2v5ZYY4Ud+BRczZg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:42AM +0100, Antonio Pérez wrote:
> On Wed, Oct 30, 2019 at 9:41 AM Anand Jain <anand.jain@oracle.com> wrote:
> 
> > +#define HELPINFO_INSERT_QUITE                                                  \
> 
> Typo?

Yes it's a typo, should be 'quiet'.
