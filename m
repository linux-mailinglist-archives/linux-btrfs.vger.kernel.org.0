Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616229A91C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbfHWHsp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 03:48:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728519AbfHWHsp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 03:48:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EEABAECA;
        Fri, 23 Aug 2019 07:48:42 +0000 (UTC)
Subject: Re: [PATCH 4/9] btrfs: rework btrfs_space_info_add_old_bytes
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20190822191102.13732-1-josef@toxicpanda.com>
 <20190822191102.13732-5-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <b3a697e5-016d-5c8c-f0c6-711e433ca18f@suse.com>
Date:   Fri, 23 Aug 2019 10:48:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822191102.13732-5-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.08.19 г. 22:10 ч., Josef Bacik wrote:
> If there are pending tickets and we are overcommitted we will simply
> return free'd reservations to space_info->bytes_may_use if we cannot
> overcommit any more.  This is problematic because we assume any free
> space would have been added to the tickets, and so if we go from an
> overcommitted state to not overcommitted we could have plenty of space
> in our space_info but be unable to make progress on our tickets because
> we only refill tickets from previous reservations.
> 
> Consider the following example.  We were allowed to overcommit to
> space_info->total_bytes + 2mib.  Now we've allocated all of our chunks
> and are no longer allowed to overcommit those extra 2mib.  Assume there
> is a 3mib reservation we are now freeing.  Because we can no longer
> overcommit we do not partially refill the ticket with the 3mib, instead
> we subtract it from space_info->bytes_may_use.  Now the total reserved
> space is 1mib less than total_bytes, meaning we have 1mib of space we
> could reserve.  Now assume that our ticket is 2mib, and we only have
> 1mib of space to reclaim, so we have a partial refilling to 1mib.  We
> keep trying to flush and eventually give up and ENOSPC the ticket, when
> there was the remaining 1mib left in the space_info for usage.

The wording of this paragraph makes it a bit hard to understand. How
about something like:

Consider an example where a request is allowed to overcommit
space_info->total_bytes + 2mib. At this point it's no longer possible to
overcommit extra space. At the same time there is an existing 3mib
reservation which is being freed. Due to the existing check failing:

if (check_overcommit &&
  !can_overcommit(fs_info, space_info, 0, flush, false))

btrfs_space_info_add_old_bytes won't partially refill tickets with those
3mib, instead it will subtract them from space_info->bytes_may_use. This
results in the total reserved space being 1mib below
space_info->total_bytes. <You need to expand on where the 2mib ticket
came - was it part of the original reservation that caused the
overcommit or is it a new reservation that comes while we are at 1mb
below space_info->total_bytes>

> 
> Instead of doing this partial filling of tickets dance we need to simply
> add our space to the space_info, and then do the normal check to see if
> we can satisfy the whole reservation.  If we can then we wake up the
> ticket and carry on.  This solves the above problem and makes it much
> more straightforward to understand how the tickets are satisfied.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c | 43 ++++++++++++++++---------------------------
>  1 file changed, 16 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index a0a36d5768e1..357fe7548e07 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -233,52 +233,41 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
>  				    struct btrfs_space_info *space_info,
>  				    u64 num_bytes)
>  {
> -	struct reserve_ticket *ticket;
>  	struct list_head *head;
> -	u64 used;
>  	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_NO_FLUSH;
> -	bool check_overcommit = false;
>  
>  	spin_lock(&space_info->lock);
>  	head = &space_info->priority_tickets;
> +	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
>  
> -	/*
> -	 * If we are over our limit then we need to check and see if we can
> -	 * overcommit, and if we can't then we just need to free up our space
> -	 * and not satisfy any requests.
> -	 */
> -	used = btrfs_space_info_used(space_info, true);
> -	if (used - num_bytes >= space_info->total_bytes)
> -		check_overcommit = true;
>  again:
> -	while (!list_empty(head) && num_bytes) {
> -		ticket = list_first_entry(head, struct reserve_ticket,
> -					  list);
> -		/*
> -		 * We use 0 bytes because this space is already reserved, so
> -		 * adding the ticket space would be a double count.
> -		 */
> -		if (check_overcommit &&
> -		    !can_overcommit(fs_info, space_info, 0, flush, false))
> -			break;
> -		if (num_bytes >= ticket->bytes) {
> +	while (!list_empty(head)) {
> +		struct reserve_ticket *ticket;
> +		u64 used = btrfs_space_info_used(space_info, true);
> +
> +		ticket = list_first_entry(head, struct reserve_ticket, list);
> +
> +		/* Check and see if our ticket can be satisified now. */
> +		if ((used + ticket->bytes <= space_info->total_bytes) ||
> +		    can_overcommit(fs_info, space_info, ticket->bytes, flush,
> +				   false)) {
> +			btrfs_space_info_update_bytes_may_use(fs_info,
> +							      space_info,
> +							      ticket->bytes);
>  			list_del_init(&ticket->list);
> -			num_bytes -= ticket->bytes;
>  			ticket->bytes = 0;
>  			space_info->tickets_id++;
>  			wake_up(&ticket->wait);
>  		} else {
> -			ticket->bytes -= num_bytes;
> -			num_bytes = 0;
> +			break;
>  		}
>  	}
>  
> -	if (num_bytes && head == &space_info->priority_tickets) {
> +	if (head == &space_info->priority_tickets) {
>  		head = &space_info->tickets;
>  		flush = BTRFS_RESERVE_FLUSH_ALL;
>  		goto again;
>  	}
> -	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
>  	spin_unlock(&space_info->lock);
>  }
>  
> 
